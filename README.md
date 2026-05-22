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

| Day | What I Did | File |
|-----|-----------|------|
| 1–3 | First extraction attempts — prompt building and refinement | Phase-1-AI-Tools/prompts/ |
| 4 | First Lloyd's PDF extraction using master prompt | day-04-lloyds-extraction.md |
| 5 | Refined prompt — added risk and business class extraction | day-05-refined-prompts.md |
| 6 | Speed test — full extraction in under 60 seconds | Lloyds-Prompt-Library.md |

**Phase 1 Result:** Can extract all 12 financial fields from any Lloyd's syndicate PDF in under 60 seconds.

---

### ✅ Phase 2 — SQL Basics (Days 7–13)

Query Lloyd's syndicate data with SQL in DB Browser for SQLite.

| Day | What I Did | File |
|-----|-----------|------|
| 7 | Created syndicate_financials database and first SELECT queries | day-07-first-queries.sql |
| 8 | SELECT and WHERE — filter syndicates by combined ratio and profit | day-08-where-queries.sql |
| 9 | COUNT and NULL — data completeness check on all key fields | day-09-completeness-check.sql |
| 10 | GROUP BY — average combined ratio by managing agent | day-10-groupby-analysis.sql |
| 11 | JOIN — created syndicate_details table, combined financial and business data | day-11-join-queries.sql |
| 12 | CASE WHEN — automatic performance labels for every syndicate | day-12-case-when.sql |
| 13 | Master quality check query — all missing fields in one run | master-lloyds-quality-check.sql |

**Phase 2 Result:** Can query Lloyd's data to find profitable syndicates, flag missing data, compare managing agents, join business context, and automatically label every syndicate.

---

### ✅ Phase 3 — Power BI Advanced (Days 14–19)

Build a live Lloyd's performance dashboard.

| Day | What I Did | Status |
|-----|-----------|--------|
| 14 | Connected Power BI to SQLite — first bar chart and scatter chart built | ✅ Done |
| 15 | Built 5 KPI cards with DAX measures — conditional formatting on combined ratio | ✅ Done |
| 16 | Drill-through built — click managing agent to see all their syndicates | ✅ Done |
| 17 | Slicers + Data Quality Page — 3 slicers working, Performance Label DAX column created | ✅ Done |
| 18 | Executive Summary Page — 4 KPIs, text summary, Top 3 Managing Agents | 🔲 Tomorrow |
| 19 | Full dashboard rebuild revision — target under 45 minutes | 🔲 Upcoming |

---

### 🔲 Phase 4 — Automation (Days 20–26)

Connect everything into one automatic pipeline.

| Day | Focus |
|-----|-------|
| 20 | SQL views — save quality checks as reusable views |
| 21 | Power BI scheduled refresh — dashboard updates at 8 AM daily |
| 22 | Power BI alerts — fire when combined ratio or missing data thresholds crossed |
| 23 | Power Automate — auto email when alert fires |
| 24 | Error log and quality trend chart |
| 25 | Exception queue — flagged syndicates routed for manual review |
| 26 | Full pipeline test end to end |

---

### 🔲 Phase 5 — Job Ready (Days 27–30)

Present the Lloyd's system to a VP.

| Day | Focus |
|-----|-------|
| 27 | Write one-page system summary document |
| 28 | Record 3-minute presentation on screen |
| 29 | Mock interview — answer 5 VP questions using Lloyd's examples |
| 30 | Full rehearsal — pipeline to dashboard to business value |

---

## Day 17 Highlight — Slicers + Data Quality Page

**What I built:** Page 3 Data Quality Dashboard with 3 working slicers.

**Problem I solved:**
Performance Label gave error — "non-measure field required for slicer".

**Root cause:** I had created Performance Label as a Measure using Average Combined Ratio. Slicers only accept Columns, not Measures.

**Fix:** Created as a Calculated Column under Table tools → New Column using DAX SWITCH on the actual column value, not a measure.

```dax
Performance Label =
SWITCH(
    TRUE(),
    syndicate_clean[combined_ratio_pct] < 95,  "Strong Performer",
    syndicate_clean[combined_ratio_pct] < 100, "Marginal",
    syndicate_clean[combined_ratio_pct] < 110, "Loss Making",
    syndicate_clean[combined_ratio_pct] >= 110, "Significant Loss",
    "No Data"
)
```

**3 Slicers on Page 3 — Data Quality:**

| Slicer | Column Used |
|--------|------------|
| Year of Account | year_of_account |
| Managing Agent | managing_agent |
| Performance Label | Performance Label (DAX calculated column) |

**Key lesson:** Measure vs Column is one of the most common Power BI mistakes. Measures aggregate many rows into one number. Columns store a value per row. Slicers need one value per row — always use a Column.

---

## Day 12 Highlight — CASE WHEN Performance Labels

Every syndicate automatically classified — no manual work needed.

```sql
SELECT
    f.syndicate_number,
    f.syndicate_name,
    f.combined_ratio_pct,
    CASE
        WHEN f.combined_ratio_pct IS NULL    THEN 'No Data'
        WHEN f.combined_ratio_pct < 95       THEN 'Strong Performer'
        WHEN f.combined_ratio_pct < 100      THEN 'Marginal'
        WHEN f.combined_ratio_pct < 110      THEN 'Loss Making'
        WHEN f.combined_ratio_pct >= 110     THEN 'Significant Loss'
    END AS performance_label
FROM syndicate_clean f
ORDER BY f.combined_ratio_pct ASC;
```

**My Syndicates Labelled:**

| Syndicate | Name | Combined Ratio | Label |
|-----------|------|---------------|-------|
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
| syndicate_clean | 7 | Financial data — GWP, combined ratio, profit, claims |
| syndicate_details | 6 | Business class, domicile, active status |

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
│       ├── day-16-drill-through.png
│       └── day-17-slicers.png
│
├── Phase-4-Automation/
│   └── pipeline/               (coming Days 20–26)
│
├── Phase-5-Job-Ready/          (coming Days 27–30)
│
└── README.md
```

---

## What I Can Do Right Now

| Skill | Tool | What I Built |
|-------|------|-------------|
| Extract syndicate financials from any Lloyd's PDF | Claude AI | Under 60 seconds per PDF |
| Query and filter syndicate data | SQL | WHERE, GROUP BY, JOIN, COUNT |
| Validate data quality automatically | SQL | NULL checks, completeness rate |
| Auto-label every syndicate | SQL CASE WHEN | Strong / Marginal / Loss / Significant Loss |
| Live performance dashboard — 3 pages complete | Power BI | KPIs, drill-through, slicers |
| Data quality monitoring with filters | Power BI Page 3 | 3 slicers filtering completeness data live |

---

---

*Building in public — 30 days of real Lloyd's data, real tools, real automation.*
