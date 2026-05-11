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

### 4. Day 12 Full Challenge
```sql
SELECT
    o.waiter_name,
    SUM(o.total_amount)  AS total_sales,
    CASE
        WHEN SUM(o.total_amount) > 100 THEN 'Top Performer'
        WHEN SUM(o.total_amount) > 50  THEN 'Mid Performer'
        ELSE 'Low Performer'
    END AS performance_label
FROM orders o
JOIN menu_items m ON o.order_id = m.order_id
WHERE m.category = 'Mains'
GROUP BY o.waiter_name
ORDER BY total_sales DESC
LIMIT 3;
```

---

## 💡 Key Lessons Learned

- `WHERE` filters **before** grouping
- `HAVING` filters **after** grouping
- Table names with spaces need `" "` quotes
- `JOIN` always needs `ON table1.col = table2.col`
- `LIMIT` always pairs with `ORDER BY`
