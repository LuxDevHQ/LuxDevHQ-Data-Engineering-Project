### **MedAdvantage RAF Engine Project**

## 1. Overview

The **MedAdvantage RAF Engine** is a mini end-to-end risk adjustment analytics project. It uses synthetic Medicare Advantage data (members, medical claims, pharmacy claims) generated with Mockaroo, loaded into **PostgreSQL**, and transformed with **dbt (data build tool)** to produce member-level risk metrics.

---

## 2. Data Sources and Schemas

The project uses three primary source tables in PostgreSQL, populated from CSV files exported from Mockaroo:

1. `members`  
2. `medical_claims`  
3. `pharmacy_claims`  

### 2.1 `members` Table

```sql
CREATE TABLE members (
    member_id      INT PRIMARY KEY,
    first_name     TEXT,
    last_name      TEXT,
    dob            DATE,
    gender         TEXT,
    state          TEXT,
    zip            TEXT,
    plan_id        TEXT,
    dual_status    BOOLEAN,
    esrd_flag      BOOLEAN,
    effective_date DATE,
    term_date      DATE
);
```

### 2.2 `medical_claims` Table

```sql
CREATE TABLE medical_claims (
    claim_id         UUID PRIMARY KEY,
    member_id        INT REFERENCES members(member_id),
    claim_type       TEXT,
    service_start    DATE,
    service_end      DATE,
    paid_amount      NUMERIC(12,2),
    place_of_service TEXT,
    diag1            TEXT,
    diag2            TEXT,
    diag3            TEXT,
    diag4            TEXT
);
```

### 2.3 `pharmacy_claims` Table

```sql
CREATE TABLE pharmacy_claims (
    rx_claim_id  UUID PRIMARY KEY,
    member_id    INT REFERENCES members(member_id),
    ndc_code     TEXT,
    fill_date    DATE,
    days_supply  INT,
    quantity     INT,
    drug_tier    TEXT,
    paid_amount  NUMERIC(12,2)
);
```

### 2.4 Mapping Tables

In addition, two small static mapping tables are created manually (for demonstration purposes):

- `icd_to_hcc(icd10_code, hcc_code, hcc_desc, weight)`  
- `ndc_to_rxhcc(ndc_code, rxhcc_code, rxhcc_desc, weight)`

These can be stored as dbt seeds or regular tables.

---

## 3. dbt Project Structure (PostgreSQL Target)

The dbt project follows a simple layered structure with staging, core, and mart models:

- `models/staging/*.sql` – one model per source table, light cleaning  
- `models/core/*.sql` – core fact/dimension tables for analytics  
- `models/marts/*.sql` – final risk adjustment marts (member HCCs, risk scores)  

### 3.1 Example `profiles.yml` (PostgreSQL)

```yaml
medadvantage_raf_engine:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: your_username
      password: your_password
      port: 5432
      dbname: medadvantage
      schema: analytics
      threads: 4
```

### 3.2 `dbt_project.yml` (Key Parts)

```yaml
name: 'medadvantage_raf_engine'
version: '1.0.0'
config-version: 2

profile: 'medadvantage_raf_engine'

models:
  medadvantage_raf_engine:
    staging:
      +schema: staging
      +materialized: view
    core:
      +schema: core
      +materialized: table
    marts:
      +schema: marts
      +materialized: table
```

---

## 4. Staging Models (dbt)

Staging models lightly clean and standardize the raw Mockaroo data. They are typically materialized as views.

### 4.1 `models/staging/stg_members.sql`

```sql
with source as (
    select * from {{ source('raw', 'members') }}
),
renamed as (
    select
        member_id,
        lower(first_name) as first_name,
        lower(last_name) as last_name,
        dob,
        gender,
        state,
        zip,
        plan_id,
        dual_status,
        esrd_flag,
        effective_date,
        term_date
    from source
)
select * from renamed;
```

### 4.2 `models/staging/stg_medical_claims.sql`

```sql
with source as (
    select * from {{ source('raw', 'medical_claims') }}
),
renamed as (
    select
        claim_id,
        member_id,
        claim_type,
        service_start,
        coalesce(service_end, service_start) as service_end,
        paid_amount,
        place_of_service,
        diag1,
        diag2,
        diag3,
        diag4
    from source
)
select * from renamed;
```

### 4.3 `models/staging/stg_pharmacy_claims.sql`

```sql
with source as (
    select * from {{ source('raw', 'pharmacy_claims') }}
),
renamed as (
    select
        rx_claim_id,
        member_id,
        ndc_code,
        fill_date,
        days_supply,
        quantity,
        drug_tier,
        paid_amount
    from source
)
select * from renamed;
```

---

## 5. Core Models (dbt)

Core models provide cleaned, analytics-ready tables for members and claims. They are typically materialized as tables in the `core` schema.

### 5.1 `models/core/core_members.sql`

```sql
select
    member_id,
    first_name,
    last_name,
    dob,
    gender,
    state,
    zip,
    plan_id,
    dual_status,
    esrd_flag,
    effective_date,
    term_date,
    date_part('year', age(current_date, dob)) as age
from {{ ref('stg_members') }};
```

### 5.2 `models/core/core_medical_claims.sql`

```sql
select
    claim_id,
    member_id,
    claim_type,
    service_start,
    service_end,
    paid_amount,
    place_of_service,
    diag1,
    diag2,
    diag3,
    diag4,
    date_part('year', service_start) as service_year
from {{ ref('stg_medical_claims') }};
```

### 5.3 `models/core/core_pharmacy_claims.sql`

```sql
select
    rx_claim_id,
    member_id,
    ndc_code,
    fill_date,
    days_supply,
    quantity,
    drug_tier,
    paid_amount,
    date_part('year', fill_date) as service_year
from {{ ref('stg_pharmacy_claims') }};
```

---

## 6. Mart Models: HCC & Risk Scores

Mart models implement simplified HCC and RxHCC logic. In a real project, the mapping tables and coefficients would follow CMS specifications; here we demonstrate the pattern.

### 6.1 `models/marts/member_hccs.sql`

```sql
with diagnoses as (
    select
        mc.member_id,
        mc.service_year,
        unnest(array[diag1, diag2, diag3, diag4]) as icd10_code
    from {{ ref('core_medical_claims') }} mc
),
mapped as (
    select
        d.member_id,
        d.service_year,
        m.hcc_code,
        m.weight
    from diagnoses d
    join {{ source('refdata', 'icd_to_hcc') }} m
      on d.icd10_code = m.icd10_code
),
deduped as (
    select distinct
        member_id,
        service_year,
        hcc_code,
        max(weight) as weight
    from mapped
    group by member_id, service_year, hcc_code
)
select * from deduped;
```

### 6.2 `models/marts/member_risk_scores.sql`

```sql
with base as (
    select
        m.member_id,
        m.age,
        m.gender,
        m.plan_id,
        h.service_year,
        coalesce(sum(h.weight), 0) as hcc_weight
    from {{ ref('core_members') }} m
    left join {{ ref('member_hccs') }} h
      on m.member_id = h.member_id
    group by m.member_id, m.age, m.gender, m.plan_id, h.service_year
),
demo_factor as (
    select
        member_id,
        service_year,
        case
            when age >= 85 then 0.5
            when age >= 75 then 0.4
            when age >= 65 then 0.3
            else 0.2
        end as age_factor,
        case when gender = 'M' then 0.1 else 0.05 end as gender_factor
    from base
)
select
    b.member_id,
    b.service_year,
    b.age,
    b.gender,
    b.plan_id,
    b.hcc_weight,
    d.age_factor,
    d.gender_factor,
    1.0 + b.hcc_weight + d.age_factor + d.gender_factor as risk_score
from base b
join demo_factor d
  on b.member_id = d.member_id
 and b.service_year = d.service_year;
```

---

## 7. Running the Transformations

After configuring the PostgreSQL connection in `profiles.yml` and creating the raw tables, copy the SQL files above into the appropriate dbt model directories. Then run:

1. `dbt seed` (if you store mapping tables as seeds)  
2. `dbt run --select staging`  
3. `dbt run --select core`  
4. `dbt run --select marts`  
5. `dbt test` – to execute data tests and validations  

The final mart table **`member_risk_scores`** contains one row per member per service year with a simplified risk score that combines HCC weights and demographic factors.
