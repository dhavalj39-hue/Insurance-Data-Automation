# Day 6 — Speed Test + Lloyd's Prompt Library
**Date:** 05-05-2026
**Phase:** 1 — AI First
**Focus:** Speed test + finalise prompt library

---

## Morning Speed Test Result
- Task: Extract full financial table from Lloyd's PDF without notes
- Tool: Claude
- Time taken: Under 60 seconds ✅
- Fields extracted correctly: 12/12
- NULLs flagged correctly: Yes

---

## What I Can Now Do in 60 Seconds
That previously took 20+ minutes of manual PDF reading:
- Extract all 12 financial fields from any Lloyd's syndicate PDF
- Identify missing fields and mark as NULL
- Get risk factors and business class summary
- Compare two syndicates side by side

---

## Speed Test Prompt Used
"This is a Lloyd's syndicate annual report. Extract these fields 
into a table: syndicate number, managing agent, year of account, 
GWP, net written premium, gross claims paid, net claims incurred, 
net operating expenses, profit before tax, combined ratio, total 
assets, members funds. Note currency unit. NULL if missing."

---

## Prompt Library Summary

| Task | Tool | Time |
|---|---|---|
| Full financial extraction | Claude | 60 sec |
| Risk and strategy | Claude | 30 sec |
| Compare two syndicates | Claude | 2 min |
| Validate extracted data | ChatGPT | 1 min |
| Executive summary | Claude | 30 sec |

---

## Phase 1 Complete — What I Built
- Extracted 7 Lloyd's syndicates from real PDFs
- Built reusable prompt library for any future syndicate
- Reduced extraction time from 25 minutes to 60 seconds
- Data ready to load into SQL database — Day 7 starts tomorrow

---

## Tomorrow — Day 7
- Install DB Browser for SQLite ✅ already done
- Create lloyds_syndicate_data.db ✅ already done
- Create syndicate_financials table
- Insert 5 syndicate rows
- Run first SELECT * query
