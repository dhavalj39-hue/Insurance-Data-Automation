# Day 7 — SQL Setup + First Queries
**Date:** 05-05-2026
**Phase:** 2 — SQL Basics
**Tool:** DB Browser for SQLite

---

## What I Built Today
- Opened DB Browser for SQLite
- Created database: lloyds_syndicate_data.db
- Imported 7 Lloyd's syndicate rows from Excel
- Ran first SELECT * query — 7 rows returned in 15ms

---

## Problem Found and Fixed
**Problem:** combined_ratio_pct column was TEXT not REAL
**Impact:** WHERE combined_ratio_pct > 100 returned ALL rows incorrectly
**Fix:** Used CAST to convert TEXT to REAL

```sql
CREATE TABLE "SQL Master files_fixed" AS
SELECT *,
CAST(combined_ratio_pct AS REAL) AS combined_ratio_pct
FROM "SQL Master files";
```

**Lesson:** Always check data types before writing WHERE queries
This is real data quality work — same issue happens in every job

---

## Queries I Wrote Today

| Query | Keyword Used | Business Question Answered |
|---|---|---|
| ORDER BY gwp_000s DESC | ORDER BY DESC | Who writes most premium? |
| WHERE combined_ratio_pct > 100 | WHERE | Which syndicates are unprofitable? |
| WHERE pbt_000s > 1 | WHERE | Which syndicates made profit? |
| COUNT(syndicate_name) | COUNT | How many syndicates in database? |
| WHERE combined_ratio_pct IS NULL | IS NULL | Where is data missing? |
| gwp_000s / 1000 AS gwp_millions | AS | Show GWP in millions for VP |

---

## Key Results
- Beazley (623) = highest GWP at 974,700
- Arcus/Barbican = lowest GWP
- 7 syndicates total in database
- Some pbt_000s showing NULL — data quality issue for Day 9

---

## What I Understand Now
- SELECT = which columns to show
- FROM = which table
- WHERE = filter rows by condition
- ORDER BY = sort results
- DESC = biggest first, ASC = smallest first
- COUNT() = count rows
- IS NULL = find missing values
- AS = rename/label a column
- CAST = convert data type

---

## Tomorrow — Day 8
- WHERE queries — 5 filter exercises
- Find profitable syndicates
- Find syndicates with missing data
- Compare managing agents
