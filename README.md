# Lloyd's Syndicate Data Portfolio

**30-Day Build | SQL · Power BI · AI Tools (Claude & ChatGPT)**  
Real Data: Lloyd's Syndicate Reports & Accounts

---

## What This Project Does

This repository documents a 30-day build of a fully automated Lloyd's syndicate data pipeline:

1. **Claude AI** extracts structured financial data from Lloyd's syndicate PDFs in under 60 seconds
2. **SQL** validates data quality — completeness checks, outlier detection, missing field flags
3. **Power BI** displays a live 4-page Lloyd's performance dashboard (built in Phase 3)
4. **Power Automate** sends alerts when thresholds are crossed (built in Phase 4)

> "In 30 days I built a working Lloyd's syndicate data automation system using Claude AI, ChatGPT, SQL, and Power BI. A PDF that used to take 20+ minutes of manual reading now produces a clean table in under 60 seconds."

---

## Repository Structure

```
Lloyds-Syndicate-Data-Portfolio/
│
├── Phase-1-AI-Tools/
│   └── prompts/
│       ├── day-01-prompts.md
│       ├── day-02-prompts.md
│       ├── day-03-prompts.md
│       ├── day-04-lloyds-extraction.md
│       ├── day-05-refined-prompts.md
│       ├── day-06-prompt-library.md
│       └── Lloyds-Prompt-Library.md
│
├── Phase-2-SQL/
│   └── queries/
│       ├── create-lloyds-database.sql
│       ├── day-07-first-queries.sql
│       ├── day-08-where-queries.sql        ← Added today
│       ├── day-09-completeness-check.sql   ← Added today
│       ├── day-10-groupby-analysis.sql
│       ├── day-11-join-queries.sql
│       ├── day-12-case-when.sql
│       └── master-lloyds-quality-check.sql
│
├── Phase-3-PowerBI/
│   └── screenshots/
│
├── Phase-4-Automation/
│   └── pipeline/
│
├── Phase-5-Job-Ready/
│
└── README.md
```

---

## Progress Log

### Phase 1 — AI First (Days 1–6) ✅

| Day | File | What I Did |
|-----|------|------------|
| 1 | day-01-prompts.md | First extraction prompt attempt — sustainability report |
| 2 | day-02-prompts.md | Prompt refinement — improved field targeting |
| 3 | day-03-prompts.md | Excel validation and ChatGPT formula work |
| 4 | day-04-lloyds-extraction.md | First Lloyd's PDF extraction — two syndicates compared |
| 5 | day-05-refined-prompts.md | Refined prompt with risk and business class extraction |
| 6 | day-06-prompt-library.md | Lloyd's Prompt Library — 5 best prompts documented |

**Phase 1 Result:** Can extract a full 12-field Lloyd's syndicate financial table from any PDF in under 60 seconds.

---

### Phase 2 — SQL Basics (Days 7–13) 🔄 In Progress

| Day | File | What I Did |
|-----|------|------------|
| 7 | create-lloyds-database.sql | Created `syndicate_financials` table, entered first 8 syndicates |
| 7 | day-07-first-queries.sql | First SELECT * — confirmed all rows returned correctly |
| 8 | day-08-where-queries.sql | SELECT + WHERE — 10 filter queries on real syndicate data |
| 9 | day-09-completeness-check.sql | COUNT + NULL — 6 data quality queries, completeness rate tracked |

#### Day 8 — SELECT & WHERE

**Concept:** SELECT chooses columns. WHERE filters rows.  
**Queries written:** 10 — unprofitable syndicates, profitable syndicates, missing data, strong performers, high GWP, filter by agent, filter by year, AND conditions, full row inspection.

Key learning: `WHERE combined_ratio IS NULL` — you cannot use `= NULL` in SQL. Must be `IS NULL`.

#### Day 9 — COUNT & NULL

**Concept:** COUNT(*) counts all rows. SUM(CASE WHEN ... END) counts rows matching a condition.  
**Queries written:** 6 — full completeness summary, completeness rate %, row-by-row MISSING/OK status, quick ratio check, missing data by year, completeness by managing agent.

Key learning: Use `100.0` not `100` for percentage division in SQLite — integer division gives wrong result.

**Week 1 completeness rate:** _____%  *(record after running Query 2 in day-09 file)*

---

### Phase 3 — Power BI (Days 14–19) ⏳ Coming Soon

### Phase 4 — Automation (Days 20–26) ⏳ Coming Soon

### Phase 5 — Job Ready (Days 27–30) ⏳ Coming Soon

---

## Data Schema

All syndicate data is stored in `lloyds_syndicate_data.db` (SQLite).  
Table name: `SQL Master files_fixed`

```sql
CREATE TABLE "SQL Master files_fixed" (
    syndicate_number     INT,     -- Unique syndicate identifier
    syndicate_name       TEXT,    -- Full name of the syndicate
    managing_agent       TEXT,    -- Agent responsible for running the syndicate
    year_of_account      INT,     -- Underwriting year
    report_type          TEXT,    -- Type of Lloyd's report
    gwp_000s             REAL,    -- Gross Written Premium (£000s)
    nwp_000s             REAL,    -- Net Written Premium (£000s)
    net_claims_000s      REAL,    -- Net Claims Incurred (£000s)
    net_opex_000s        REAL,    -- Net Operating Expenses (£000s)
    pbt_000s             REAL,    -- Profit / Loss Before Tax (£000s)
    combined_ratio_pct   REAL,    -- Combined Ratio % — under 100 = profitable
    total_assets_000s    REAL,    -- Total Assets (£000s)
    members_funds_000s   REAL,    -- Members Funds / Capital (£000s)
    currency_unit        TEXT,    -- Currency unit as stated in source PDF
    source_doc           TEXT,    -- Source PDF filename or reference
    notes                TEXT     -- Any extraction notes or flags
);
```

**Column naming convention:** `_000s` suffix = figures in £thousands. `_pct` suffix = percentage value.  
**Key rule:** `combined_ratio_pct` under 100 = profitable underwriting. Above 100 = loss.

---

## Tools Used

| Tool | Purpose |
|------|---------|
| Claude AI | Extract financial tables from Lloyd's syndicate PDFs |
| ChatGPT | Write and explain SQL queries, validate extracted data |
| DB Browser for SQLite | Run SQL queries on local database |
| Power BI Desktop | Build live Lloyd's performance dashboard (Phase 3) |
| Power Automate | Automated email alerts on data thresholds (Phase 4) |
| GitHub | Daily portfolio — 30 consecutive days of commits |

---

## Data Source

Lloyd's of London publishes annual syndicate reports publicly at:  
[lloyds.com — Syndicate Reports and Accounts](https://www.lloyds.com/about-lloyds/investor-relations/syndicate-reports-and-accounts)

These are real financial documents used by investors and regulators worldwide.
