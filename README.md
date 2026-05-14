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

| Field | SQL Column | Why It Matters |
| --- | --- | --- |
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
| 7 | Created syndicate_clean database and first SELECT queries | `day-07-first-queries.sql` |
| 8 | SELECT and WHERE — filter syndicates by combined ratio and profit | `day-08-where-queries.sql` |
| 9 | COUNT and NULL — data completeness check on all key fields | `day-09-completeness-check.sql` |
| 10 | GROUP BY — average combined ratio by managing agent | `day-10-groupby-analysis.sql` |
| 11 | JOIN — created syndicate_details table, combined financial + business data | `day-11-join-queries.sql` |
| 12 | CASE WHEN — automatic performance labels for every syndicate | `day-12-case-when.sql` |
| **13** | **Revision — master quality check query across all key fields** | **`master-lloyds-quality-check.sql`** |

**Phase 2 Result:** Can query Lloyd's data to find profitable syndicates, flag missing data, compare managing agents, join business context, automatically label every syndicate, and run a full quality check in one query.

---

### 🔲 Phase 3 — Power BI (Days 14–19)

Build a live Lloyd's performance dashboard.

| Day | Focus |
| --- | --- |
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

## Day 13 Highlight — Master Quality Check Query

One query surfaces every record with any missing key field across the entire dataset. Run this after every new batch of syndicate data is loaded.

```sql
SELECT
    syndicate_number,
    managing_agent,
    year_of_account,
    CASE WHEN gwp_000s            IS NULL THEN 'MISSING' ELSE 'OK' END AS gwp_status,
    CASE WHEN net_claims_000s     IS NULL THEN 'MISSING' ELSE 'OK' END AS claims_status,
    CASE WHEN combined_ratio_pct  IS NULL THEN 'MISSING' ELSE 'OK' END AS ratio_status,
    CASE WHEN pbt_000s            IS NULL THEN 'MISSING' ELSE 'OK' END AS profit_status
FROM syndicate_clean
WHERE
    gwp_000s              IS NULL
    OR net_claims_000s    IS NULL
    OR combined_ratio_pct IS NULL
    OR pbt_000s           IS NULL;
```

**Day 13 also covered all 5 revision tasks without notes:**
- ✅ Show all loss-making syndicates
- ✅ Count syndicates by managing agent
- ✅ Find missing combined ratio
- ✅ JOIN financials with details table
- ✅ CASE WHEN performance labels

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

| Table | Rows | What It Contains |
| --- | --- | --- |
| `syndicate_clean` | 7 | Financial data — GWP, CR, profit, claims |
| `syndicate_details` | 6 | Business class, domicile, active status |

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
│       ├── day-12-case-when.sql
│       ├── day-12-progress.md
│       └── master-lloyds-quality-check.sql   ← NEW DAY 13
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
| --- | --- | --- |
| Extract syndicate financials from any Lloyd's PDF | Claude AI | Under 60 seconds per PDF |
| Query and filter syndicate data | SQL | WHERE, GROUP BY, JOIN, COUNT |
| Validate data quality automatically | SQL | NULL checks, completeness rate |
| Combine financial + business data | SQL JOIN | Two-table query with context |
| Auto-label every syndicate | SQL CASE WHEN | Strong / Marginal / Loss / Significant Loss |
| Run full quality check in one query | SQL Master Check | All missing fields flagged instantly |

---

*Building in public — 30 days of real Lloyd's data, real tools, real automation.*
