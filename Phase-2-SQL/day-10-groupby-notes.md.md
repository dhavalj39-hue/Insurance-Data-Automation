# Day 10 — SQL & Lloyd's Syndicate Database

## Topics Covered

### 1. Real Database Analysis
- Database: Lloyd's Syndicate Data (SQLite)
- Tool: DB Browser for SQLite
- Tables: "syndicate_clean"

### 2. Queries Practiced

#### Combined Ratio by Managing Agent
```sql
SELECT
  managing_agent,
  COUNT(*) AS syndicate_count,
  ROUND(AVG(combined_ratio_pct), 1) AS avg_combined_ratio,
  ROUND(AVG(pbt_000s), 0) AS avg_profit
FROM "syndicate_clean"
GROUP BY managing_agent
ORDER BY avg_combined_ratio ASC;
```

#### Profitable vs Loss Making
```sql
SELECT
  CASE
    WHEN pbt_000s > 0 THEN 'Profitable'
    WHEN pbt_000s < 0 THEN 'Loss Making'
    ELSE 'Unknown'
  END AS performance,
  COUNT(*) AS count
FROM "syndicate_clean"
GROUP BY performance;
```

#### NULL Detection
```sql
SELECT
    COUNT(*)                                                        AS total_rows,
    SUM(CASE WHEN gwp_000s           IS NULL THEN 1 ELSE 0 END)    AS missing_gwp,
    SUM(CASE WHEN nwp_000s           IS NULL THEN 1 ELSE 0 END)    AS missing_nwp,
    SUM(CASE WHEN pbt_000s           IS NULL THEN 1 ELSE 0 END)    AS missing_pbt,
    SUM(CASE WHEN combined_ratio_pct IS NULL THEN 1 ELSE 0 END)    AS missing_ratio,
    SUM(CASE WHEN total_assets_000s  IS NULL THEN 1 ELSE 0 END)    AS missing_assets,
    SUM(CASE WHEN members_funds_000s IS NULL THEN 1 ELSE 0 END)    AS missing_funds
FROM syndicate_clean;
```

### 3. Key Concepts Learned
- GROUP BY and aggregate functions
- CASE WHEN conditional logic
- ROUND() for readable output
- TYPEOF() to inspect data types
- quote() to reveal raw stored values
- Difference between real NULL vs text 'NULL'

### 4. Bug Found & Solved Today
- Data imported from Excel stored empty cells as TEXT 'NULL'
- IS NULL failed because values were not real NULL
- Used quote() function to reveal the hidden text
- Fixed by using = 'NULL' instead of IS NULL

## Key Lesson
> Empty cells from Excel become text 'NULL' in SQLite
> Always use quote() to check what is really stored!
