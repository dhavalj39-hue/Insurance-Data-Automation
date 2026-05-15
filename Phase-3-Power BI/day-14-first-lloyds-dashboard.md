# Day 14 — First Lloyd's Dashboard in Power BI

**Date:** 14 May 2026
**Phase:** Phase 3 — Power BI Advanced
**Focus:** Connect Power BI to Lloyd's syndicate data and build first visuals

---

## What I Built Today

Connected Power BI Desktop to `syndicate_clean.csv` and built the first 3 visuals on Page 1 of the dashboard.

---

## How I Connected the Data

- Opened Power BI Desktop
- Click **Home → Get Data → Text/CSV**
- Selected `syndicate_clean.csv`
- Power BI loaded the table automatically — 11 rows, 13 columns
- Verified column names matched the Lloyd's schema from Phase 2 SQL work

> Note: Attempted ODBC connection to SQLite database — this did not work in this environment. Used CSV export from syndicate_clean table instead. CSV loaded cleanly with all columns and data types correct.

---

## Dashboard — Page 1 Screenshot

> Screenshot: `day-14-first-lloyds-dashboard.png`

**Three visuals built:**

| Visual | Type | X-Axis | Y-Axis / Category |
|--------|------|--------|-------------------|
| GWP by Syndicate Name | Horizontal bar chart | Sum of gwp_000s | syndicate_name |
| PBT by Managing Agent | Horizontal bar chart | Sum of pbt_000s | managing_agent |
| Combined Ratio vs PBT | Scatter chart | Sum of combined_ratio_pct | Sum of pbt_000s |

---

## Visuals Detail

### Visual 1 — GWP by Syndicate Name
- X axis = Sum of gwp_000s (bars stretch left to right showing premium size)
- Y axis = syndicate_name (syndicates listed top to bottom)
- Beasley is the largest syndicate by Gross Written Premium at ~£975k
- ACE Underwriting, AEGIS London, Antares, Arcus/Barbican follow in order
- Long tail of smaller syndicates below (Nephila, Pembroke, RiverStone, R&Q)

### Visual 2 — PBT by Managing Agent
- X axis = Sum of pbt_000s (bars show profit size)
- Y axis = managing_agent (agents listed top to bottom)
- Beasley Furlonge Limited leads on Profit Before Tax at ~£180k
- ACE Underwriting and AEGIS Managing Agency follow
- Antares, RiverStone, Nephila in mid-range
- Polo and Barbican Managing Agencies at the lower end

### Visual 3 — Combined Ratio vs PBT Scatter (by syndicate_number)
- X axis = Sum of combined_ratio_pct
- Y axis = Sum of pbt_000s
- Each dot = one syndicate, colour-coded by syndicate number
- Shows the expected inverse relationship: lower combined ratio → higher profit
- Syndicates clustered in the 60–80% combined ratio range with PBT up to ~£200k
- One outlier visible near combined ratio ~100 — flagged for review

---

## Data Source

- File: `syndicate_clean.csv`
- Rows: 11 syndicates
- Columns: 13 financial fields
- All figures in £000s
- Data extracted from Lloyd's syndicate annual report PDFs using Claude (Phase 1)
- CSV exported from SQLite syndicate_clean table built in Phase 2

---

## How I Built the Visuals — ChatGPT Assisted

Power BI Copilot was not available in this environment. Used ChatGPT instead to get step-by-step instructions for building each visual manually.

**ChatGPT prompts I used:**

| Visual | Prompt I Asked ChatGPT |
|--------|----------------------|
| GWP bar chart | "How do I build a horizontal bar chart in Power BI showing gross written premium by syndicate name" |
| PBT bar chart | "How do I build a horizontal bar chart in Power BI showing profit before tax by managing agent" |
| Scatter chart | "How do I build a scatter chart in Power BI with combined ratio on X axis and profit before tax on Y axis coloured by syndicate number" |

ChatGPT gave step-by-step instructions — I followed them manually in Power BI Desktop and built each visual myself.

---

## What Worked

- CSV loaded into Power BI cleanly — all 13 columns and 11 rows imported correctly
- ChatGPT instructions were accurate — visuals built correctly following the steps
- Scatter chart immediately visible — shows combined ratio performance distribution across the market
- All 3 visuals cross-filter each other — clicking a managing agent filters the scatter
- Changed PBT bar chart to green to visually distinguish from GWP blue chart
- Added plain English titles to all 3 visuals — removed default database column name labels

---

## What Did Not Work — Lessons Learned

| Issue | What Happened | What I Did Instead |
|-------|--------------|-------------------|
| ODBC SQLite connection | Could not establish connection in this environment | Exported syndicate_clean as CSV and loaded via Get Data → Text/CSV |
| Power BI Copilot | Not available in current Power BI Desktop version | Used ChatGPT for step-by-step build instructions instead |

> Next step: set up ODBC connection properly for Day 21 scheduled refresh — CSV will not auto-refresh, database connection will.

---

## What to Improve Tomorrow (Day 15)

- Add 5 KPI cards: Total Market GWP, Profitable Syndicates %, Average Combined Ratio, Missing Data Count, Loss Making Syndicates count
- Add DAX measures for calculated KPIs — will use ChatGPT to write DAX syntax
- Add conditional formatting: combined ratio card turns red above 100, green below 95
- Add year of account slicer to filter dashboard by year
- Resolve ODBC connection so dashboard can auto-refresh from database in Day 21

---

## Time Log

| Task | Time |
|------|------|
| Attempt ODBC connection — did not work | 10 min |
| Load CSV via Get Data → Text/CSV | 5 min |
| Ask ChatGPT for visual build instructions | 5 min |
| Build Visual 1 — GWP bar chart | 5 min |
| Build Visual 2 — PBT bar chart | 5 min |
| Build Visual 3 — Scatter chart | 8 min |
| Formatting, titles, colours, layout | 10 min |
| **Total** | **~48 min** |

---

## Key Learning

> When a tool does not work — find the alternative and keep moving. Power BI Copilot was unavailable so ChatGPT filled the same role. The visuals are identical. The skill is in knowing what to build and why — not which AI tool helped you build it.

> In a horizontal bar chart — X axis always holds the numbers, Y axis always holds the categories. The bars stretch left to right along the X axis showing the value size.

> Documenting what did not work is as important as documenting what did. Real data operations work involves troubleshooting — showing that process on GitHub demonstrates professional maturity.

---

*File location: `Phase-3-PowerBI/day-14-first-lloyds-dashboard.md`*
*Screenshot location: `Phase-3-PowerBI/screenshots/day-14-first-lloyds-dashboard.png`*
