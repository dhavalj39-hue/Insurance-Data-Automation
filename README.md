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
|------|---------|
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
|-------|-----------|----------------|
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

| Day | What I Did | Status |
|-----|-----------|--------|
| 1–3 | First extraction attempts — prompt building and refinement | ✅ Done |
| 4 | First Lloyd's PDF extraction using master prompt | ✅ Done |
| 5 | Refined prompt — added risk and business class extraction | ✅ Done |
| 6 | Speed test — full extraction in under 60 seconds | ✅ Done |

**Phase 1 Result:** Can extract all 12 financial fields from any Lloyd's syndicate PDF in under 60 seconds.

---

### ✅ Phase 2 — SQL Basics (Days 7–13)

Query Lloyd's syndicate data with SQL in DB Browser for SQLite.

| Day | What I Did | Status |
|-----|-----------|--------|
| 7 | Created syndicate_financials database and first SELECT queries | ✅ Done |
| 8 | SELECT and WHERE — filter syndicates by combined ratio and profit | ✅ Done |
| 9 | COUNT and NULL — data completeness check on all key fields | ✅ Done |
| 10 | GROUP BY — average combined ratio by managing agent | ✅ Done |
| 11 | JOIN — created syndicate_details table, combined financial + business data | ✅ Done |
| 12 | CASE WHEN — automatic performance labels for every syndicate | ✅ Done |
| 13 | Revision — master quality check query | ✅ Done |

**Phase 2 Result:** Can query Lloyd's data to find profitable syndicates, flag missing data, compare managing agents, join business context, and automatically label every syndicate.

---

### ✅ Phase 3 — Power BI (Days 14–19)

Build a live Lloyd's performance dashboard.

| Day | What I Did | Status |
|-----|-----------|--------|
| 14 | Connected Power BI to SQLite database — first bar charts and scatter charts | ✅ Done |
| 15 | KPI cards + DAX measures — 5 cards with conditional formatting | ✅ Done |
| 16 | Drill-through — managing agent bar chart → syndicate detail page | ✅ Done |
| 17 | Slicers and data quality page | 🔲 Upcoming |
| 18 | Executive summary page | 🔲 Upcoming |
| 19 | Full rebuild revision | 🔲 Upcoming |

---

### 🔲 Phase 4 — Automation (Days 20–26)

Connect everything into one automatic pipeline.

| Day | Focus |
|-----|-------|
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

## Day 15 Highlight — KPI Cards + DAX Measures

Five live KPI cards built using DAX — all update automatically when slicers filter the data.

| KPI Card | DAX Measure | Formatting |
|----------|-------------|-----------|
| Total Market GWP | `SUM(syndicate_financials[gwp_000s])` | £000s |
| Profitable Syndicates % | `DIVIDE(COUNTROWS(FILTER(...profit > 0)), COUNTROWS(...)) * 100` | % |
| Average Combined Ratio | `AVERAGE(syndicate_financials[combined_ratio_pct])` | Red > 100 / Green < 95 |
| Missing Data Count | `COUNTROWS(FILTER(...ISBLANK fields))` | Count |
| Loss Making Syndicates | `COUNTROWS(FILTER(...profit < 0))` | Count |

**Key learning:** Conditional formatting on the Combined Ratio card — turns red when the market average is above 100 (unprofitable), green when below 95 (strong underwriting profit).

---

## Day 16 Highlight — Drill-Through Navigation

Built drill-through from managing agent bar chart to a dedicated syndicate detail page.

**How it works:**
1. Page 1 — bar chart showing Profit Before Tax by managing agent
2. Right-click any bar → Drill through → Syndicate Detail
3. Page 2 opens filtered to only that agent's syndicates
4. Power BI adds "Back to report" button automatically

**Setup:** Dragged `managing_agent` into the Drill through well on Page 2 (Visualizations pane). The field on Page 1's Y-axis must match the drill-through field exactly.

**Real data visible in dashboard:**

| Managing Agent | Profit Before Tax (£000s) |
|----------------|--------------------------|
| Beazley Furlonge Limited | 180,800 |
| ACE Underwriting Agencies Ltd | 154,645 |
| AEGIS Managing Agency Ltd | 60,500 |
| Antares Managing Agency Limited | 18,386 |
| RiverStone Managing Agency Limited | 17,029 |

---

## Day 12 Highlight — CASE WHEN Performance Labels

Every syndicate automatically classified — no manual work needed.

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

| Syndicate | Name | CR | Label |
|-----------|------|----|-------|
| 2488 | ACE | 62 | Strong Performer |
| 6110 | Pembroke | 68 | Strong Performer |
| 623 | Beazley | 84 | Strong Performer |
| 1225 | AEGIS London | 84 | Strong Performer |
| 1274 | Antares | 92 | Strong Performer |
| 1856 | Arcus/Barbican | 106 | Loss Making |

---

## My Database — Current Status

| Table | Rows | What It Contains |
|-------|------|-----------------|
| `syndicate_clean` | 7 | Financial data — GWP, CR, profit, claims |
| `syndicate_details` | 6 | Business class, domicile, active status |

---

## What I Can Do Right Now

| Skill | Tool | What I Built |
|-------|------|-------------|
| Extract syndicate financials from any Lloyd's PDF | Claude AI | Under 60 seconds per PDF |
| Query and filter syndicate data | SQL | WHERE, GROUP BY, JOIN, COUNT |
| Validate data quality automatically | SQL | NULL checks, completeness rate |
| Combine financial + business data | SQL JOIN | Two-table query with context |
| Auto-label every syndicate | SQL CASE WHEN | Strong / Marginal / Loss / Significant Loss |
| Build KPI dashboard | Power BI + DAX | 5 live KPI cards with conditional formatting |
| Drill-through navigation | Power BI | Managing agent → syndicate detail |

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
│       └── master-lloyds-quality-check.sql
│
├── Phase-3-PowerBI/
│   └── screenshots/
│       ├── day-14-first-dashboard.png
│       ├── day-15-kpi-cards.png
│       └── day-16-drill-through.png
│
├── Phase-4-Automation/
│   └── pipeline/           ← coming Days 20–26
│
├── Phase-5-Job-Ready/      ← coming Days 27–30
│
└── README.md
```

---

*Building in public — 30 days of real Lloyd's data, real tools, real automation.*
