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
| --- | --- |
| Claude AI | Extract syndicate financials from PDFs |
| ChatGPT | Write and explain SQL queries |
| DB Browser for SQLite | Run and test SQL queries |
| Power BI | Live performance dashboard |
| Power Automate | Automated alerts pipeline |
| GitHub | Daily progress documentation |

---

## Real Data — Lloyd's Syndicate Reports

All data extracted from real publicly available Lloyd's syndicate annual reports from lloyds.com

| Field | SQL Column | Data Type | Why It Matters |
| --- | --- | --- | --- |
| Syndicate Number | syndicate_number | INTEGER | Unique identifier |
| Syndicate Name | syndicate_name | TEXT | Full name of syndicate |
| Managing Agent | managing_agent | TEXT | Who runs the syndicate |
| Year of Account | year_of_account | INTEGER | Which underwriting year |
| Report Type | report_type | TEXT | Annual Accounts or Closed UY (36 months) |
| Gross Written Premium | gwp_000s | REAL | Total premiums before reinsurance |
| Net Written Premium | nwp_000s | REAL | Premiums after reinsurance |
| Net Claims Incurred | net_claims_000s | REAL | Claims net of reinsurance recoveries |
| Net Operating Expenses | net_opex_000s | REAL | Running costs of the syndicate |
| Profit / Loss Before Tax | pbt_000s | REAL | Bottom line performance |
| Combined Ratio | combined_ratio_pct | REAL | Under 100 = profitable |
| Total Assets | total_assets_000s | REAL | Total syndicate asset base |
| Members Funds | members_funds_000s | REAL | Capital backing the syndicate |

> All figures in £000s. NULL values present where data not available in source PDF.

---

## 30-Day Plan Progress

### ✅ Phase 1 — AI First (Days 1–6)

Extract Lloyd's syndicate data from PDFs automatically using Claude and ChatGPT.

| Day | What I Did | File |
| --- | --- | --- |
| 1–3 | First extraction attempts — prompt building and refinement | `Phase-1-AI-Tools/prompts/` |
| 4 | First Lloyd's PDF extraction using master prompt | `day-04-lloyds-extraction.md` |
| 5 | Refined prompt — added risk and business class extraction | `day-05-refined-prompts.md` |
| 6 | Speed test — full extraction in under 60 seconds | `Lloyds-Prompt-Library.md` |

**Phase 1 Result:** Can extract all 12 financial fields from any Lloyd's syndicate PDF in under 60 seconds.

---

### ✅ Phase 2 — SQL Basics (Days 7–13)

Query Lloyd's syndicate data with SQL in DB Browser for SQLite.

| Day | What I Did | File |
| --- | --- | --- |
| 7 | Created syndicate_financials database and first SELECT queries | `day-07-first-queries.sql` |
| 8 | SELECT and WHERE — filter syndicates by combined ratio and profit | `day-08-where-queries.sql` |
| 9 | COUNT and NULL — data completeness check on all key fields | `day-09-completeness-check.sql` |
| 10 | GROUP BY — average combined ratio by managing agent | `day-10-groupby-analysis.sql` |
| 11 | JOIN — created syndicate_details table, combined financial + business data | `day-11-join-queries.sql` |
| 12 | CASE WHEN — automatic performance labels for every syndicate | `day-12-case-when.sql` |
| 13 | Revision — master quality check query covering all missing fields in one run | `master-lloyds-quality-check.sql` |

**Phase 2 Result:** Can query Lloyd's data to find profitable syndicates, flag missing data, compare managing agents, join business context, and automatically label every syndicate. Master quality check runs in one SQL line.

---

### 🔄 Phase 3 — Power BI (Days 14–19)

Build a live Lloyd's performance dashboard.

| Day | What I Did | Status |
| --- | --- | --- |
| 14 | Connected Power BI to SQLite. Built Page 1: GWP by syndicate, PBT by managing agent, combined ratio vs profit scatter chart | ✅ Done |
| 15 | KPI cards and DAX measures | 🔲 Tomorrow |
| 16 | Drill-through by managing agent | 🔲 Upcoming |
| 17 | Slicers and data quality page | 🔲 Upcoming |
| 18 | Executive summary page | 🔲 Upcoming |
| 19 | Full rebuild revision | 🔲 Upcoming |

---

### 🔲 Phase 4 — Automation (Days 20–26)

Connect everything into one automatic pipeline.

| Day | Focus |
| --- | --- |
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

## Day 14 Highlight — First Lloyd's Dashboard Built

Page 1 of the Lloyd's Syndicate Performance Dashboard is live in Power BI.

**Three visuals built on Page 1:**

| Visual | Type | What It Shows |
| --- | --- | --- |
| Gross Written Premium by Syndicate | Horizontal bar (blue) | Beasley leads market GWP at ~£1M |
| Profit Before Tax by Managing Agent | Horizontal bar (green) | Beasley Furlonge Limited top performer |
| Combined Ratio vs PBT | Scatter chart | Inverse relationship visible — lower CR = higher profit |

**Key observations from the dashboard:**
- Beasley is the largest syndicate by GWP and also top by PBT
- ACE Underwriting and AEGIS London consistently in the top tier
- Scatter chart confirms expected pattern: syndicates with combined ratio 60–85% showing highest profit
- One syndicate near combined ratio 100 with elevated PBT — flagged for review in Day 15 quality checks

Screenshot: `Phase-3-PowerBI/screenshots/day-14-first-lloyds-dashboard.png`

---

## Day 12 Highlight — CASE WHEN Performance Labels

Every syndicate now automatically classified — no manual work needed.

```sql
SELECT
    f.syndicate_number,
    f.syndicate_name,
    f.combined_ratio_pct,
    CASE
        WHEN f.combined_ratio_pct IS NULL   THEN 'No Data'
        WHEN f.combined_ratio_pct < 95      THEN 'Strong Performer'
        WHEN f.combined_ratio_pct < 100     THEN 'Marginal'
        WHEN f.combined_ratio_pct < 110     THEN 'Loss Making'
        WHEN f.combined_ratio_pct >= 110    THEN 'Significant Loss'
    END AS performance_label
FROM syndicate_clean f
ORDER BY f.combined_ratio_pct ASC;
```

### My Syndicates Labelled

| Syndicate | Name | CR | Label |
| --- | --- | --- | --- |
| 2488 | ACE | 62 | Strong Performer |
| 6110 | Pembroke | 68 | Strong Performer |
| 623 | Beazley | 84 | Strong Performer |
| 1225 | AEGIS London | 84 | Strong Performer |
| 1274 | Antares | 92 | Strong Performer |
| 1856 | Arcus/Barbican | 106 | Loss Making |

---

## My Database — Current Status

**Table: `syndicate_clean`** — 11 rows, 13 columns

| Syndicate | Name | Managing Agent | Year | Report Type | GWP (£000s) | CR % | PBT (£000s) |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 623 | Beazley | Beazley Furlonge Limited | 2023 | Annual Accounts | 974,700 | 84.0 | 180,800 |
| 2488 | ACE Underwriting | ACE Underwriting Agencies Ltd | 2014 | Annual Accounts | 375,327 | 62.0 | 154,645 |
| 1225 | AEGIS London | AEGIS Managing Agency Ltd | 2014 | Annual Accounts | 371,000 | 84.0 | 60,500 |
| 1274 | Antares | Antares Managing Agency Limited | 2014 | Annual Accounts | 250,576 | 92.0 | 18,386 |
| 1856 | Arcus/Barbican | Barbican Managing Agency Limited | 2019 | Annual Accounts | 106,530 | 106.0 | 0 |
| 2358 | Nephila | Nephila Syndicate Management Ltd | 2022 | Annual Accounts | 48,598 | 88.3 | 2,282 |
| 780 | RiverStone | RiverStone Managing Agency Ltd | 2020 | Annual Accounts | 8,309 | NULL | 17,029 |
| 1110 | R&Q | R&Q Syndicate Management Ltd | 2023 | Annual Accounts | 5,561 | NULL | 0 |
| 1254 | Polo | Polo Managing Agency Limited | 2022 | Annual Accounts | 2,507 | NULL | 2,117 |
| 6110 | Pembroke | Pembroke Managing Agency Ltd | 2015 | Annual Accounts | 1,140 | 68.0 | 1,242 |
| 6110 | Pembroke | Pembroke Managing Agency Ltd | 2013 | Closed UY (36 months) | 40,988 | NULL | 922 |

**Data quality notes:**
- 4 syndicates have NULL combined_ratio_pct — flagged by Day 9 completeness check query
- net_claims_000s and net_opex_000s are 0 for most syndicates — data not available in source PDFs
- report_type column added — distinguishes Annual Accounts from Closed Underwriting Year records

---

## Repository Structure

```
Insurance-Data-Automation/
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
│       ├── day-11-progress.md
│       ├── day-12-case-when.sql
│       ├── day-12-progress.md
│       └── master-lloyds-quality-check.sql    ← Day 13
│
├── Phase-3-PowerBI/
│   └── screenshots/
│       └── day-14-first-lloyds-dashboard.png  ← Day 14 ✅
│
├── Phase-4-Automation/
│   └── pipeline/           ← coming Days 20–26
│
├── Phase-5-Job-Ready/      ← coming Days 27–30
│
├── syndicate_clean.csv     ← live database export (11 syndicates, 13 columns)
│
└── README.md
```

---

## What I Can Do Right Now

| Skill | Tool | What I Built |
| --- | --- | --- |
| Extract syndicate financials from any Lloyd's PDF | Claude AI | Under 60 seconds per PDF |
| Query and filter syndicate data | SQL | WHERE, GROUP BY, JOIN, COUNT |
| Validate data quality automatically | SQL | NULL checks, completeness rate |
| Combine financial + business data | SQL JOIN | Two-table query with context |
| Auto-label every syndicate | SQL CASE WHEN | Strong / Marginal / Loss / Significant Loss |
| Visualise Lloyd's performance | Power BI | Page 1 dashboard — GWP, PBT, scatter chart |

---

## Daily Log

| Day | Date | Completed |
| --- | --- | --- |
| 1–3 | Retrospective | First Claude extractions documented |
| 4 | Phase 1 | Master extraction prompt — Lloyd's PDF to table |
| 5 | Phase 1 | Refined prompt with risk + business class |
| 6 | Phase 1 | Prompt library built — under 60 sec per PDF |
| 7 | Phase 2 | Database created, first SELECT queries |
| 8 | Phase 2 | WHERE filters — profitable syndicates |
| 9 | Phase 2 | NULL checks — completeness rate query |
| 10 | Phase 2 | GROUP BY — managing agent analysis |
| 11 | Phase 2 | JOIN — financial + business data combined |
| 12 | Phase 2 | CASE WHEN — performance labels automated |
| 13 | Phase 2 | Master quality check — all fields one query |
| 14 | Phase 3 | **Power BI Page 1 built — GWP, PBT, scatter** |

---

*Building in public — 30 days of real Lloyd's data, real tools, real automation.*
