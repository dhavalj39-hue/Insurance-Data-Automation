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
| ChatGPT | Write and explain SQL queries + generate insight text |
| DB Browser for SQLite | Run and test SQL queries |
| Power BI | Live performance dashboard |
| Power Automate | Automated alerts pipeline |
| GitHub | Daily progress documentation |

---

## Real Data — Lloyd's Syndicate Reports

All data extracted from real publicly available Lloyd's syndicate annual reports from lloyds.com

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
| 7 | Created syndicate_financials database and first SELECT queries | `day-07-first-queries.sql` |
| 8 | SELECT and WHERE — filter syndicates by combined ratio and profit | `day-08-where-queries.sql` |
| 9 | COUNT and NULL — data completeness check on all key fields | `day-09-completeness-check.sql` |
| 10 | GROUP BY — average combined ratio by managing agent | `day-10-groupby-analysis.sql` |
| 11 | JOIN — created syndicate_details table, combined financial + business data | `day-11-join-queries.sql` |
| 12 | CASE WHEN — automatic performance labels for every syndicate | `day-12-case-when.sql` |
| 13 | Revision — master quality check query, all missing fields in one run | `master-lloyds-quality-check.sql` |

**Phase 2 Result:** Can query Lloyd's data to find profitable syndicates, flag missing data, compare managing agents, join business context, and automatically label every syndicate.

---

### ✅ Phase 3 — Power BI (Days 14–19) — In Progress

Build a live Lloyd's performance dashboard.

| Day | What I Did | File |
|---|---|---|
| 14 | Connected Power BI to SQLite database via ODBC. Built Page 1 — GWP by syndicate, combined ratio distribution, profit/loss by managing agent | `day-14-first-lloyds-dashboard.png` |
| 15 | Created 5 KPI cards with DAX measures — Total GWP, Profitable %, Avg Combined Ratio, Missing Data Count, Loss Making count. Conditional formatting on combined ratio card | `day-15-kpi-cards.png` |
| 16 | Built Page 2 — drill-through from managing agent to individual syndicate detail. Tested all agents | `day-16-drill-through.png` |
| 17 | Added slicers — year of account, managing agent, performance label. Built Page 3 — data quality dashboard with completeness rate KPI | `day-17-slicers-quality-page.png` |
| 18 | Built Page 4 — executive summary: 4 KPI cards, Top 3 agents by combined ratio, AI-generated insight text, conditional formatting. Power BI Copilot unavailable — used ChatGPT for insight text and manual DAX for all measures | `day-18-executive-summary.png` |
| 19 | Full dashboard rebuild from scratch — in progress | Coming tomorrow |

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

## Day 18 Highlight — Executive Summary Dashboard Page

Page 4 of the Lloyd's dashboard — the first page a VP sees.

**Insight text (generated via ChatGPT, based on SQL data):**
> "The Lloyd's syndicate performance data indicates that the market remains broadly profitable,
> with several syndicates reporting strong underwriting performance and healthy profit-before-tax
> figures. Results were primarily driven by low combined ratios — particularly from syndicates
> managed by Beazley, ACE, and AEGIS — which suggest effective claims control and underwriting
> discipline across top performers. However, there are notable data quality concerns, including
> missing combined ratio values for multiple syndicates and duplicate entries for Syndicate 6110,
> which may affect the reliability and completeness of performance analysis."

**KPI cards built:**

| Measure | Value |
|---|---|
| Syndicates analysed | 6 |
| Strong performers (CR < 95) | 5 |
| Average combined ratio | ~82.7% |
| Data completeness | 100% |

**Note:** Power BI Copilot not available — ChatGPT used for insight text, manual DAX for all measures. Same output, full understanding of every number.

---

## My Syndicates — Current Data

| Syndicate | Name | Combined Ratio | Label |
|---|---|---|---|
| 2488 | ACE | 62 | Strong Performer |
| 6110 | Pembroke | 68 | Strong Performer |
| 623 | Beazley | 84 | Strong Performer |
| 1225 | AEGIS London | 84 | Strong Performer |
| 1274 | Antares | 92 | Strong Performer |
| 1856 | Arcus/Barbican | 106 | Loss Making |

---

## My Database — Current Status

| Table | Rows | What It Contains |
|---|---|---|
| `syndicate_financials` | 6 | Financial data — GWP, CR, profit, claims |
| `syndicate_details` | 6 | Business class, domicile, active status |

**Known issue:** Duplicate entry for Syndicate 6110 identified — to be resolved before Day 19 full rebuild.

---

## What I Can Do Right Now

| Skill | Tool | What I Built |
|---|---|---|
| Extract syndicate financials from any Lloyd's PDF | Claude AI | Under 60 seconds per PDF |
| Query and filter syndicate data | SQL | WHERE, GROUP BY, JOIN, COUNT |
| Validate data quality automatically | SQL | NULL checks, completeness rate |
| Combine financial + business data | SQL JOIN | Two-table query with context |
| Auto-label every syndicate | SQL CASE WHEN | Strong / Marginal / Loss / Significant Loss |
| Build live performance dashboard | Power BI | 4-page Lloyd's dashboard |
| Generate executive insight text | ChatGPT | AI summary from SQL data |
| Apply conditional formatting and DAX | Power BI | KPI cards with colour thresholds |

---

## Repository Structure
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
│       └── master-lloyds-quality-check.sql
│
├── Phase-3-PowerBI/
│   └── screenshots/
│       ├── day-14-first-lloyds-dashboard.png
│       ├── day-15-kpi-cards.png
│       ├── day-16-drill-through.png
│       ├── day-17-slicers-quality-page.png
│       └── day-18-executive-summary.png
│
├── Phase-4-Automation/
│   └── pipeline/           ← coming Days 20–26
│
├── Phase-5-Job-Ready/      ← coming Days 27–30
│
└── README.md

---

*Building in public — 30 days of real Lloyd's data, real tools, real automation.*
