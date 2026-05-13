## ✅ Day 12 Progress — Clauses Mastered

| Clause | Purpose | Status |
|---|---|---|
| `SELECT` | Choose columns | ✅ Mastered |
| `FROM` | Pick table | ✅ Mastered |
| `WHERE` | Filter rows | ✅ Mastered |
| `JOIN` | Connect tables | ✅ Mastered |
| `GROUP BY` | Group results | ✅ Mastered |
| `HAVING` | Filter groups | ✅ Mastered |
| `CASE WHEN` | Label results | ✅ Mastered |
| `ORDER BY` | Sort results | ✅ Mastered |
| `LIMIT` | Restrict rows | ✅ Mastered |

---

## 📝 Queries Written Today

### 1. Active Syndicates
```sql
SELECT syndicate_number, syndicate_name, managing_agent
FROM "SQL Master files" f
JOIN syndicate_details d
    ON f.syndicate_number = d.syndicate_number
WHERE active_status = 'Active';
```

### 2. Managing Agent Scorecard
```sql
SELECT managing_agent, COUNT(*) AS total_syndicates
FROM "SQL Master files" f
JOIN syndicate_details d ON f.syndicate_number = d.syndicate_number
WHERE active_status = 'Active'
GROUP BY managing_agent;
```

### 3. Performance Labels
```sql
SELECT
    syndicate_number,
    syndicate_name,
    managing_agent,
    combined_ratio_pct,
    CASE
        WHEN combined_ratio_pct < 95  THEN 'Strong Performer'
        WHEN combined_ratio_pct < 100 THEN 'Marginal'
        WHEN combined_ratio_pct < 110 THEN 'Loss Making'
        WHEN combined_ratio_pct >= 110 THEN 'Significant Loss'
        ELSE 'No Data'
    END AS performance_label
FROM "SQL Master files" f
JOIN syndicate_details d ON f.syndicate_number = d.syndicate_number
WHERE active_status = 'Active'
  AND combined_ratio_pct != 'NULL'
ORDER BY combined_ratio_pct ASC;
```

```

---

## 💡 Key Lessons Learned

- `WHERE` filters **before** grouping
- `HAVING` filters **after** grouping
- Table names with spaces need `" "` quotes
- `JOIN` always needs `ON table1.col = table2.col`
- `LIMIT` always pairs with `ORDER BY`
