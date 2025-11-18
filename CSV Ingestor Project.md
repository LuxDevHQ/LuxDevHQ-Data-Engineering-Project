### **CSV Ingestor – Robust, Crash-Safe File Pipeline (Student Project)**

---

Welcome to your mini-capstone project. In this project, you’ll build a **production-style file ingestor** that:

- Watches a **staging directory** on Linux for new CSV files  
- Detects **when files are actually complete** (not mid-copy)  
- Computes **metadata + hashes**  
- Writes a **JSONL manifest**  
- Moves files into a **date-partitioned warehouse**  
- Guarantees **no double-processing** (exactly-once behavior)  

You’ll do this in **small, guided phases**, so don’t worry if the full specification looks big at first.

---

## 1. Project Overview

### 1.1 Scenario

Your team runs a data platform. Upstream systems send you **large CSV files** by dropping them into a Linux directory (e.g., `/staging`) using tools like `scp`, `rsync`, or cron jobs.

Complications:

- Files can arrive **slowly** (written in chunks).
- Files might be written to a temp name like `file.csv.tmp` and then **renamed atomically** to `file.csv` when done.
- Upstream systems might **re-send the same file** (same content, different name) when they’re not sure if you ingested it.

Your job is to build a **robust ingestor** that:

1. Detects when files are **fully written** (and ignores partials).
2. Writes a **manifest** line with key metadata.
3. Moves files into a **partitioned warehouse** directory.
4. Ensures **exactly-once** ingestion: no double processing, even if content is re-sent.

---

## 2. What You Will Build

You will create a **single script/binary** (e.g., `ingestor.py` or `csv_ingestor`) that:

- Watches a configurable **input directory** (`--input`, e.g., `/staging`).
- Detects **complete** files using one of two modes:
  - **Stability** mode: file is considered complete when its size and modification time are unchanged for `N` seconds.
  - **Sidecar** mode: file is considered complete when a matching `.ok` file appears (e.g., `foo.csv` + `foo.csv.ok`).
- Ignores **hidden files** and **temporary suffixes** like `.tmp`, `.part`, `.swp`.
- For each complete file:
  - Computes **SHA-256 hash**.
  - Reads file metadata: `(device, inode, size, mtime)`.
  - Appends a **JSON Lines** record to a manifest file:  
    `/manifests/YYYY/MM/DD/HH/manifest.jsonl`.
  - Moves the file into a warehouse directory:  
    `/warehouse/ingest_date=YYYY-MM-DD/`.
- Handles **same filesystem vs cross-filesystem** moves correctly:
  - Same FS: use atomic `rename()`.
  - Cross FS: copy + `fsync` + `rename`.
- Guarantees **idempotence & exactly-once** semantics using a **durable state store** (e.g., SQLite).
- Is **crash-safe**: on restart, it continues without duplicate ingest or lost files.
- Exposes a **CLI** with options like:
  - `--input`, `--warehouse`, `--manifests`
  - `--mode [stability|sidecar]`, `--stability-seconds N`
  - `--concurrency N`, `--dry-run`, `--state-path`
  - `--log-level`
- Emits **structured logs** and **basic metrics**:
  - files/sec
  - bytes/sec
  - queue depth

---

## 3. Tech & Constraints

- **OS**: Linux  
- **Language**: Your choice (Python, Go, Rust preferred).  
  The README examples assume **Python 3**, but you can adapt to another language.
- **No external daemons** (like Kafka, etc.).  
  You may use standard libraries and common open-source libs (e.g., `sqlite3`, `watchdog`).
- You **cannot** use `lsof` in your solution.

---

## 4. Recommended Project Structure

```text
csv_ingestor/
├── README.md
├── requirements.txt          # if needed (e.g., watchdog)
├── ingestor/
│   ├── __init__.py
│   ├── cli.py                # argument parsing / entrypoint
│   ├── watcher.py            # directory scanning + completion detection
│   ├── state.py              # SQLite / KV store for exactly-once
│   ├── mover.py              # same-FS vs cross-FS move logic
│   ├── manifest.py           # JSONL manifest writer
│   ├── metrics.py            # basic metrics & logging helpers
│   └── main.py               # main event loop, worker pool
├── scripts/
│   ├── simulate_slow_copy.py
│   ├── simulate_rename_tmp.sh
│   ├── simulate_duplicates.sh
│   └── simulate_cross_fs.sh  # optional / simulated
└── tests/                    # optional testing
    └── test_basic_flow.sh
````

---

## 5. Step-by-Step Implementation Plan

### Phase 1 – Basic Directory Watcher & Completion Detection

**Goal:** Detect when files in `--input` are complete using the **stability window**.

#### Requirements (Phase 1)

* Monitor the directory passed via `--input` (e.g., `/staging`).
* Scan it periodically (e.g., every 5 seconds).
* For each regular file:

  * Ignore hidden files (starting with `.`).
  * Ignore temp suffixes: `.tmp`, `.part`, `.swp`.

**Implement stability mode:**

* Track `(size, mtime)` for each candidate file.
* A file is **complete** when `size` and `mtime` are unchanged for at least `--stability-seconds`.

**Suggested Behavior:**

```bash
READY: /staging/somefile.csv
```

No moving, no manifest, no DB yet.

#### Where to Implement

* **`ingestor/watcher.py`** – handles scanning and completion detection.
* **`ingestor/cli.py`** – parse `--input`, `--mode`, `--stability-seconds`.

---

### Phase 2 – Ingest & Move (No Exactly-Once Yet)

**Goal:** For each complete file, compute metadata, write to manifest, and move to warehouse.

#### Implementation

* Compute SHA-256 of the file contents.
* Gather metadata using `os.stat()`.
* Append to manifest under `/manifests/YYYY/MM/DD/HH/manifest.jsonl`.
* Move the file to `/warehouse/ingest_date=YYYY-MM-DD/`.

**Example JSON Entry:**

```json
{
  "path": "...",
  "sha256": "...",
  "device": 2049,
  "inode": 1234567,
  "size": 987654,
  "mtime": 1730546400
}
```

#### Where to Implement

* **`ingestor/mover.py`** – `compute_sha256()` and `move_to_warehouse()`.
* **`ingestor/manifest.py`** – `append_manifest()` to write JSON lines.

---

### Phase 3 – Exactly-Once & Crash Safety (State Store)

**Goal:** Ensure idempotence and exactly-once semantics.

#### Strategy

Use a durable state store (SQLite or KV store).

```sql
CREATE TABLE ingestion_state (
    device INTEGER,
    inode INTEGER,
    sha256 TEXT,
    size INTEGER,
    mtime INTEGER,
    source_path TEXT,
    warehouse_path TEXT,
    state TEXT, -- DISCOVERED, HASHED, MOVED, MANIFESTED, SKIPPED_DUPLICATE
    created_at INTEGER,
    updated_at INTEGER,
    PRIMARY KEY (device, inode)
);
CREATE UNIQUE INDEX idx_sha256 ON ingestion_state(sha256);
```

**States:** DISCOVERED → HASHED → MOVED → MANIFESTED → SKIPPED_DUPLICATE

**Crash Recovery:** On restart, resume unfinished steps safely.

---

### Phase 4 – Same-FS vs Cross-FS Moves

* Compare `st_dev` of `--input` and `--warehouse`.
* If same FS, use atomic `rename()`.
* Otherwise: copy, `fsync`, rename, and delete source.

---

### Phase 5 – CLI, Logging, Metrics, and Test Scripts

**CLI Options:**

```bash
--input /staging \
--warehouse /warehouse \
--manifests /manifests \
--mode stability \
--stability-seconds 10 \
--concurrency 4 \
--state-path /tmp/state.db \
--log-level info
```

**Logging Example:**

```json
{"level":"info","event":"file_ingested","path":"/staging/foo.csv","warehouse_path":"/warehouse/ingest_date=2025-11-18/foo.csv","sha256":"...","bytes":123456}
```

**Metrics:**

* files_processed
* bytes_processed
* queue_depth

---

## 6. Test Scenarios

### 6.1 Slow Copy

Simulate a file being written slowly – ensure stability mode waits until completion.

### 6.2 Rename from `.tmp` → `.csv`

Ensure `.tmp` is ignored, and final file is processed once renamed.

### 6.3 Duplicate Resend

Two files with identical content should be detected as duplicates and skipped.

### 6.4 Cross-FS Move

Simulate different filesystems using mount points; ensure copy + fsync + rename works.

---

## 7. Run Example

```bash
pip install -r requirements.txt
mkdir -p /tmp/staging /tmp/warehouse /tmp/manifests /tmp/state
python -m ingestor.main \
  --input /tmp/staging \
  --warehouse /tmp/warehouse \
  --manifests /tmp/manifests \
  --mode stability \
  --stability-seconds 10 \
  --concurrency 4 \
  --state-path /tmp/state/state.db \
  --log-level info
```

---

## 8. Grading / Evaluation Guidelines

| Criteria                    | Weight | Description                                               |
| --------------------------- | ------ | --------------------------------------------------------- |
| Correctness – Core Features | 40%    | Detects completed files, moves correctly, writes manifest |
| Exactly-Once & Crash Safety | 25%    | No duplicate ingestion, durable state, recovery           |
| Code Organization & Clarity | 15%    | Structure, readability, comments                          |
| CLI & Ops                   | 10%    | Flags, logs, metrics                                      |
| Advanced / Bonus            | 10%    | Sidecar mode, cross-FS correctness, scalability           |

---

## 9. Tips for Success

* Start with stability mode and simple scanning.
* Test incrementally.
* Log everything.
* Think like an operator: logs and metrics should be actionable.
* Ask for help if a concept is unclear.

---

```
