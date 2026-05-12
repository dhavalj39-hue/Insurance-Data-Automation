# AI-Based Data Extraction Project

## Objective

Extract structured environmental data from a sustainability report using AI.

---

## Day 1 Progress

- Created extraction prompt
- Extracted environmental KPIs (pages 5–10)
- Identified data quality issues

---

## Day 12 Progress — SQL Clauses Mastered (Phase 2)

### ✅ Clauses Mastered

| Clause | Purpose | Status |
|-------------|----------------------|------------|
| `SELECT` | Choose columns | ✅ Mastered |
| `FROM` | Pick table | ✅ Mastered |
| `WHERE` | Filter rows | ✅ Mastered |
| `JOIN` | Connect tables | ✅ Mastered |
| `GROUP BY` | Group results | ✅ Mastered |
| `HAVING` | Filter groups | ✅ Mastered |
| `CASE WHEN` | Label results | ✅ Mastered |
| `ORDER BY` | Sort results | ✅ Mastered |
| `LIMIT` | Restrict rows | ✅ Mastered |

### 📝 Queries Written

1. **Active Syndicates** — JOIN + WHERE to filter active records
2. **Managing Agent Scorecard** — GROUP BY + COUNT to summarize syndicates per agent
3. **Performance Labels** — CASE WHEN to classify syndicates by combined ratio
4. **Day 12 Full Challenge** — Full query combining JOIN, WHERE, GROUP BY, CASE WHEN, ORDER BY, LIMIT to rank waiter performance

### 💡 Key Lessons Learned

- `WHERE` filters **before** grouping; `HAVING` filters **after** grouping
- Table names with spaces need `" "` quotes
- `JOIN` always requires `ON table1.col = table2.col`
- `LIMIT` always pairs with `ORDER BY` for meaningful results

---

## Files

- `prompts/` → AI prompts
- `data/` → extracted dataset
- `progress/` → daily notes
- `prompts/docs/progress/Phase-2-SQL/queries/` → SQL queries (Phase 2)

---

## Next Steps

- Improve prompt
- Clean dataset
- Build dashboard
- Continue Phase 2 SQL practice
