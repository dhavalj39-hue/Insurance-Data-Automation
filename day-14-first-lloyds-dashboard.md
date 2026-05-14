# Day 14 — First Lloyd's Dashboard in Power BI

**Date:** 14 May 2026
**Phase:** Phase 3 — Power BI Advanced
**Focus:** Connect Power BI to Lloyd's syndicate data and build first visuals

---

## What I Built Today

Connected Power BI Desktop to my Lloyd's syndicate database (`syndicate_clean` table) and built the first 3 visuals on Page 1 of the dashboard.

---

## Dashboard — Page 1 Screenshot

> Screenshot: `day-14-first-lloyds-dashboard.png`

**Three visuals built:**

| Visual | Type | X-Axis / Category | Y-Axis / Value |
|--------|------|-------------------|----------------|
| GWP by Syndicate Name | Horizontal bar chart | syndicate_name | Sum of gwp_000s |
| PBT by Managing Agent | Horizontal bar chart | managing_agent | Sum of pbt_000s |
| Combined Ratio vs PBT | Scatter chart | Sum of combined_ratio_pct | Sum of pbt_000s |

---

## Visuals Detail

### Visual 1 — Sum of gwp_000s by syndicate_name
- Beasley is the largest syndicate by Gross Written Premium
- ACE Underwriting, AEGIS London, Antares, Arcus/Barbican follow in order
- Long tail of smaller syndicates below (Nephila, Pembroke, RiverStone, R&Q)

### Visual 2 — Sum of pbt_000s by managing_agent
- Beasley Furlonge Limited leads on Profit Before Tax
- ACE Underwriting and AEGIS Managing Agency follow
- Antares, RiverStone, Nephila in mid-range
- Polo and Barbican Managing Agencies at the lower end

### Visual 3 — Combined Ratio vs PBT Scatter (by syndicate_number)
- Each dot = one syndicate, colour-coded by syndicate number
- Shows the expected inverse relationship: lower combined ratio → higher profit
- Syndicates clustered in the 60–80% combined ratio range with PBT up to ~£200k
- One outlier visible near combined ratio ~100 with very high PBT — flagged for review

---

## Data Source

- Table: `syndicate_clean`
- All figures in £000s
- Data extracted from Lloyd's syndicate annual report PDFs using Claude (Phase 1)

---

## Copilot Usage

Used Power BI Copilot to generate:
- "Create a bar chart showing gross written premium by syndicate name"
- "Create a scatter chart showing combined ratio vs profit before tax coloured by syndicate number"
- "Create a bar chart showing profit before tax by managing agent"

Copilot produced the base visuals; I adjusted axis labels and formatting manually.

---

## What Worked

- ODBC connection to SQLite database loaded cleanly into Power BI
- Copilot interpreted the field names correctly from the Lloyd's schema
- Scatter chart immediately visible — shows combined ratio performance distribution across the market
- All 3 visuals cross-filter each other — clicking a managing agent filters the scatter

---

## What to Improve Tomorrow (Day 15)

- Add 5 KPI cards: Total Market GWP, Profitable Syndicates %, Average Combined Ratio, Missing Data Count, Loss Making Syndicates count
- Add DAX measures for calculated KPIs
- Add conditional formatting: combined ratio card turns red above 100, green below 95
- Titles on each visual need to be more descriptive

---

## Time Log

| Task | Time |
|------|------|
| Connect Power BI to SQLite via ODBC | 15 min |
| Build Visual 1 (GWP bar chart) | 5 min with Copilot |
| Build Visual 2 (PBT bar chart) | 5 min with Copilot |
| Build Visual 3 (Scatter chart) | 8 min with Copilot |
| Formatting and layout | 10 min |
| **Total** | **~43 min** |

---

## Key Learning

> Power BI Copilot reads the field names from your data model and interprets plain English instructions correctly — as long as your column names match the Lloyd's schema from Phase 2. Good SQL column naming in Day 7 made today significantly faster.

---

*File location: `Phase-3-PowerBI/screenshots/` + `Phase-3-PowerBI/day-14-first-lloyds-dashboard.md`*
