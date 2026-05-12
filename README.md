# Lloyd's Syndicate Data Automation Portfolio
**SQL · Power BI · AI Tools (Claude & ChatGPT)**
**Real Data: Lloyd's Syndicate Reports & Accounts**

---

## What This Project Does

This project builds a fully automated Lloyd's syndicate data pipeline:

1. **Claude AI** extracts financial data from Lloyd's syndicate PDFs automatically
2. **SQL** validates data quality and runs performance checks
3. **Power BI** displays a live dashboard updating daily
4. **Power Automate** sends alerts when thresholds are crossed

> A PDF that used to take 20+ minutes of manual reading now produces a clean structured table in under 60 seconds.

---

## Tools Used

| Tool | Purpose |
|---|---|
| Claude AI | Extract syndicate financials from PDFs |
| ChatGPT | Write and explain SQL queries |
| DB Browser for SQLite | Run and test SQL queries |
| Power BI | Live performance dashboard |
| Power Automate | Automated alerts pipeline |
| GitHub | Daily progress documentation |

---

## Real Data — Lloyd's Syndicate Reports

All data is extracted from real, publicly available Lloyd's syndicate annual reports from lloyds.com

| Field | SQL Column | Why It Matters |
|---|---|---|
| Syndicate Number | syndicate_number | Unique identifier |
| Managing Agent | managing_agent | Who runs the syndicate |
| Year of Account | year_of_account | Which underwriting year |
| Gross Written Premium | gwp_000s | Total premiums before reinsurance |
| Net Written Premium | nwp_000s | Premiums after reinsurance |
| Net Claims Incurred | net_claims_000s | Claims net of reinsurance |
| Net Operating Expenses | net_opex_000s | Running costs |
| Profit / Loss Before Tax | pbt_000s | Bottom line performance |
| Combined Ratio | combined_ratio_pct | Under 100 = profitable |
| Total Assets | total_assets_000s | Total syndicate assets |
| Members Funds | members_funds_000s | Capital backing |

---

## 30-Day Plan Progress

### ✅ Phase 1 — AI First (Days 1–6)
Extract Lloyd's syndicate data from PDFs automatically using Claude and ChatGPT.

| Day | What I Did | File |
|---|---|---|
| 1–3 | First extraction attempts — prompt building and refinement | `Phase-1-AI-Tools/prompts/` |
| 4 | First Lloyd's PDF extraction using master prompt | `day-04-lloyds-extraction.md` |
| 5 | Refined prompt — added risk and business class extraction | `day-05-refined-prompts.md` |
| 6 | Speed test — full extraction in under 60 seconds | `Lloyds-Prompt-Library.md` |

**Phase 1 Result:** Can extract all 12 financial fields from any Lloyd's syndicate PDF in under 60 seconds.

---

### ✅ Phase 2 — SQL Basics (Days 7–13)
Query Lloyd's syndicate data with SQL in DB Browser for SQLite.

| Day | What I Did | File |
|---|---|---|
| 7 | Created `syndicate_financials` database and first SELECT queries | `day-07-first-queries.sql` |
| 8 | SELECT and WHERE — filter syndicates by combined ratio and profit | `day-08-where-queries.sql` |
| 9 | COUNT and NULL — data completeness check on all key fields | `day-09-completeness-check.sql` |
| 10 | GROUP BY — average combined ratio by managing agent | `day-10-groupby-analysis.sql` |
| **11** | **JOIN — created syndicate_details table, combined financial + business data** | **`day-11-join-queries.sql`** |
| 12 | CASE WHEN — automatic performance labels | Coming tomorrow |
| 13 | Revision — master quality check query | Coming soon |

**Phase 2 Result (so far):** Can query Lloyd's data to find profitable syndicates, flag missing data, compare managing agents, and join business context to financial numbers.

---

### 🔲 Phase 3 — Power BI (Days 14–19)
Build a live Lloyd's performance dashboard.

| Day | Focus |
|---|---|
| 14 | Connect Power BI to SQLite database |
| 15 | KPI cards and DAX measures |
| 16 | Drill-through by managing agent |
| 17 | Slicers and data quality page |
| 18 | Executive summary page |
| 19 | Full rebuild revision |

---

### 🔲 Phase 4 — Automation (Days 20–26)
Connect everything into one automatic pipeline.

| Day | Focus |
|---|---|
| 20 | SQL views — save quality checks |
| 21 | Power BI scheduled refresh |
| 22 | Power BI alerts |
| 23 | Power Automate email alerts |
| 24 | Error log and quality trend |
| 25 | Exception queue |
| 26 | Full pipeline test |

---

### 🔲 Phase 5 — Job Ready (Days 27–30)
Present the Lloyd's system to a VP.

---

## Day 11 Highlight — JOIN

The biggest milestone so far. Before Day 11 my database had financial numbers but no business context. After Day 11 I can answer:

- Which class of business has the best combined ratio?
- Which syndicates are still active?
- Where is each syndicate based?

```sql
-- Day 11 core query
SELECT
    f.syndicate_number,
    f.syndicate_name,
    d.main_class_of_business,
    d.domicile,
    d.active_status,
    f.gwp_000s,
    f.combined_ratio_pct,
    f.pbt_000s
FROM "SQL Master files" f
JOIN syndicate_details d
    ON f.syndicate_number = d.syndicate_number;
```

---

## My Database — Current Status

| Table | Rows | What It Contains |
|---|---|---|
| `SQL Master files` | 7 | Financial data — GWP, CR, profit, claims |
| `SQL Master files_fixed` | 7 | Same data with REAL number types |
| `syndicate_details` | 6 | Business class, domicile, active status |

### Syndicates in Database

| Syndicate | Name | Year | CR | Status |
|---|---|---|---|---|
| 623 | Beazley | 2023 | 84 | Active |
| 1225 | AEGIS London | 2014 | 84 | Active |
| 2488 | ACE Underwriting | 2014 | 62 | Active |
| 6110 | Pembroke | 2015 | 68 | Inactive |
| 6110 | Pembroke | 2013 | NULL | Inactive |
| 1274 | Antares | 2014 | 92 | Active |
| 1856 | Arcus/Barbican | 2019 | 106 | Inactive |

---

## Repository Structure

```
Lloyds-Syndicate-Data-Portfolio/
│
├── Phase-1-AI-Tools/
│   └── prompts/
│       ├── day-04-lloyds-extraction.md
│       ├── day-05-refined-prompts.md
│       └── Lloyds-Prompt-Library.md
│
├── Phase-2-SQL/
│   └── queries/
│       ├── day-07-first-queries.sql
│       ├── day-08-where-queries.sql
│       ├── day-09-completeness-check.sql
│       ├── day-10-groupby-analysis.sql
│       ├── day-11-join-queries.sql
│       └── day-11-progress.md
│
├── Phase-3-PowerBI/
│   └── screenshots/        ← coming Days 14–19
│
├── Phase-4-Automation/
│   └── pipeline/           ← coming Days 20–26
│
├── Phase-5-Job-Ready/      ← coming Days 27–30
│
└── README.md
```

---

## What I Can Do Right Now

| Skill | Tool | What I Built |
|---|---|---|
| Extract syndicate financials from any Lloyd's PDF | Claude AI | Under 60 seconds per PDF |
| Query and filter syndicate data | SQL | WHERE, GROUP BY, JOIN, COUNT |
| Validate data quality automatically | SQL | NULL checks, completeness rate |
| Combine financial + business data | SQL JOIN | Two-table query with context |

---

*Building in public — 30 days of real Lloyd's data, real tools, real automation.*
