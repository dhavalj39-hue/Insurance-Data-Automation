# Day 10 — SQL & Lloyd's Syndicate Database

## Topics Covered

### 1. Real Database Analysis
- Database: Lloyd's Syndicate Data (SQLite)
- Tool: DB Browser for SQLite
- Tables: "SQL Master files" and "SQL Master files_fixed"

### 2. Queries Practiced

#### Combined Ratio by Managing Agent
```sql
SELECT
  managing_agent,
  COUNT(*) AS syndicate_count,
  ROUND(AVG(combined_ratio_pct), 1) AS avg_combined_ratio,
  ROUND(AVG(pbt_000s), 0) AS avg_profit
FROM "SQL Master files_fixed"
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
FROM "SQL Master files_fixed"
GROUP BY performance;
```

#### NULL Detection
```sql
SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN nep_000s = 'NULL' THEN 1 ELSE 0 END) AS nep_missing,
  SUM(CASE WHEN uw_profit_000s = 'NULL' THEN 1 ELSE 0 END) AS uw_profit_missing,
  SUM(CASE WHEN combined_ratio_pct = 'NULL' THEN 1 ELSE 0 END) AS combined_ratio_missing
FROM "SQL Master files";
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
