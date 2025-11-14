### **Workshop Project: `unifile-eda` – Unified File Reader & EDA Toolkit**

**Project Brief**

In this project, you will design and build a small Python package called `unifile-eda` for LuxDevHQ.  
The goal of the package is to make it easy for data analysts and data scientists to:

- Read **different types of data files** (CSV, TSV, Excel, JSON, Parquet, SQL tables) with a single, simple interface.  
- Automatically run a **standard Exploratory Data Analysis (EDA)** on the loaded data.  
- Generate a **shareable report** (HTML or Markdown) summarizing the dataset.

By the end of the project, you should be able to run a single command or function like:

```bash
unifile-eda profile data/members.csv --output reports/members_eda.html
```

and get a ready-made EDA report for any supported dataset.

---

**Learning Objectives**

By completing this project, students at **LuxDevHQ** will:

1. Practice designing a **Python package structure** suitable for reuse.  
2. Work with **pandas** to load and explore different file formats.  
3. Implement a **unified I/O layer** that chooses the correct reader based on file type.  
4. Build a simple but useful **EDA workflow** (summary stats, missingness, value counts).  
5. Create a basic **HTML/Markdown reporting** system for data profiling.  
6. Optionally, expose the package through a **command-line interface (CLI)**.

---

**Core Requirements**

Your `unifile-eda` package should:

1. **Load data** from:
   - CSV / TSV  
   - Excel (`.xls`, `.xlsx`)  
   - Parquet  
   - JSON  
   - (Bonus) SQL tables via a connection string  

2. **Perform EDA**, including at minimum:
   - Number of rows and columns  
   - Column data types  
   - Missing values per column  
   - Basic statistics for numeric columns (min, max, mean, quartiles)  
   - Top categories and value counts for categorical columns  

3. **Generate a report**:
   - Render the EDA results as a simple **HTML** or **Markdown** file  
   - Clearly show key information: shape, types, missingness, distributions  

4. **Provide an easy interface**:
   - A Python API (e.g., `load_data(path)`, `generate_report(df, output_path)`)  
   - (Optional but recommended) A CLI command like:  
     ```bash
     unifile-eda profile <input_file> --output <report_path>
     ```

---

**Suggested Structure**

```text
unifile-eda/
├─ pyproject.toml (or setup.py)
├─ README.md
├─ src/
│  └─ unifile_eda/
│     ├─ __init__.py
│     ├─ io.py          # handles loading different file types
│     ├─ eda.py         # computes summary statistics
│     ├─ report.py      # formats and writes the EDA report
│     └─ cli.py         # command-line interface
└─ tests/
   ├─ test_io.py
   ├─ test_eda.py
   └─ test_report.py
```
