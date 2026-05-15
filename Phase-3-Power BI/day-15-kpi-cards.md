# Day 15 — KPI Cards + DAX Measures
**Phase 3: Power BI Advanced | Lloyd's Syndicate Performance Dashboard**

---

## What I Built Today
Built 5 KPI cards in Power BI using DAX measures on real Lloyd's syndicate data.

---

## Dashboard Screenshot
> Screenshot of Power BI dashboard with KPI cards — see image uploaded to this folder.

**Dashboard: Lloyd's Syndicate Performance Dashboard**
- Total GWP: 2M (£000s)
- Average Combined Ratio: **83.47%** ✅ (Under 100 = Profitable)
- Profitable Syndicates: **9**
- Total Profit Before Tax: **438K**
- Missing Data Count: **4**

---

## 5 KPI Cards Built

| KPI Card | Value | DAX Measure Used |
|---|---|---|
| Sum of GWP (£000s) | 2M | `SUM(syndicate_financials[gwp_000s])` |
| Average Combined Ratio | 83.47% | `AVERAGE(syndicate_financials[combined_ratio_pct])` |
| Profitable Syndicates | 9 | `COUNTROWS(FILTER(..., pbt_000s > 0))` |
| Total Profit Before Tax | 438K | `SUM(syndicate_financials[pbt_000s])` |
| Missing Data Count | 4 | `SUMX(..., IF(ISBLANK(...),1,0))` |

---

## DAX Measures Written

```dax
-- KPI 1: Total GWP
Total GWP = SUM(syndicate_financials[gwp_000s])

-- KPI 2: Average Combined Ratio
Avg Combined Ratio = ROUND(AVERAGE(syndicate_financials[combined_ratio_pct]), 2)

-- KPI 3: Profitable Syndicates
Profitable Syndicates = 
COUNTROWS(
    FILTER(syndicate_financials, 
           syndicate_financials[pbt_000s] > 0)
)

-- KPI 4: Total Profit Before Tax
Total Profit Before Tax = SUM(syndicate_financials[pbt_000s])

-- KPI 5: Missing Data Count
Missing Data Count = 
SUMX(
    syndicate_financials,
    IF(ISBLANK(syndicate_financials[gwp_000s]),1,0) +
    IF(ISBLANK(syndicate_financials[combined_ratio_pct]),1,0) +
    IF(ISBLANK(syndicate_financials[pbt_000s]),1,0)
)
```

---

## Conditional Formatting Applied
- Combined Ratio card: **Green** if < 95 | **Amber** if 95–100 | **Red** if > 100
- Today's value: 83.47% → showing **Green** ✅

---

## Visuals on Dashboard
1. **Gross Written Premium by Syndicate** — horizontal bar chart by managing agent
2. **Combined Ratio vs Profit Before Tax** — scatter chart coloured by syndicate number
3. **Profit Before Tax by Managing Agent** — horizontal bar chart (green = profit)
4. **Top Strong Performers table** — syndicates with combined ratio < 95%

---

## Time Comparison
| Task | Manual | With Power BI + DAX |
|---|---|---|
| Calculate total GWP | 10 mins | Instant |
| Find profitable syndicates | 5 mins | Instant |
| Spot missing data | 20 mins | Instant |
| Build all 5 KPIs | 1 hour | 15 mins |

---

## Tools Used
- Power BI Desktop
- DAX (Data Analysis Expressions)
- Power BI Copilot
- Data source: `lloyds_syndicate_data.csv` (extracted via Claude AI)

---

## What I Can Now Do
In under 5 minutes I can connect any Lloyd's syndicate dataset to Power BI and instantly surface: total market GWP, average combined ratio, profitability count, and data quality gaps — all automatically updating when new data is loaded.

---
*Day 15 of 30 | Phase 3: Power BI Advanced | Lloyd's Syndicate Data Portfolio*
