# Day 4 Progress Notes — 04 May 2026

## Session Summary
Full Lloyd's syndicate data extraction, analysis, database build and pipeline design.

## PDFs Processed
| File | Syndicate | Managing Agent | Period |
|---|---|---|---|
| Aegis_London.pdf | 1225 | AEGIS Managing Agency Ltd | FY2014 Annual |
| ACE_Underwriting_Agencies_Limited.pdf | 2488 | ACE Underwriting Agencies Ltd | FY2014 Annual |
| pembroke.pdf | 6110 | Pembroke Managing Agency Ltd | FY2015 Annual + 2013 Closed UY |

## Tasks Completed
- [x] Extracted 11 financial fields from 2 PDFs (Part 1)
- [x] Extracted qualitative analysis from 2 PDFs (Part 2)
- [x] Generated formatted Excel report (3 tabs)
- [x] Built initial master database (AEGIS + ACE)
- [x] Merged Pembroke data (uploaded Lloyd_Syndicate_MasterDB.xlsx)
- [x] Built final master database — Lloyd_Syndicates_MASTER_v1.xlsx (5 tabs)
- [x] Drew end-to-end pipeline flowchart (interactive SVG)
- [x] Drew data consolidation strategy flowchart
- [x] Drew next-stage roadmap (no SQL background)
- [x] Normalised all values to £000s across all 3 syndicates

## Key Learning Today
- SQL needs ONE master table where every row = one record
- No SQL knowledge needed — Claude writes all queries from plain English
- Google Sheets → SQLite → Cloud DB is the natural progression
- Auto-calculated columns (Loss Ratio, Profit Margin, Asset Turnover) save manual work

## Data Quality Flags
- S1225 (AEGIS): NEP not explicitly stated in P&L; GWP was in £m, converted ×1000
- S2488 (ACE): All values native £000s; most complete dataset
- S6110 (Pembroke): Combined ratio NULL for Closed UY basis (not stated in report)
- S6110 Annual: Members' Funds negative (£134k) — syndicate winding down

## Files Created
- Lloyd_Syndicate_Report.xlsx
- Syndicate_Master_Database.xlsx
- Lloyd_Syndicates_MASTER_v1.xlsx  ← MASTER GOING FORWARD

## Next Session Plan
- Add more Lloyd's syndicate PDFs
- Load SQL READY sheet into SQLite
- First real SQL query run

