# Day 5 — Refined Prompts + Multi-Syndicate Comparison
**Date:** 05-05-2026
**Phase:** 1 — AI First

## Refined Prompt Used
"This is a Lloyd's syndicate annual report. First extract all 
financial fields into a table (syndicate number, managing agent, 
year of account, GWP, net written premium, net claims incurred, 
expenses, profit before tax, combined ratio, total assets, members 
funds — note units, NULL if missing). Then separately list:
(1) main classes of business
(2) 3 biggest risk factors
(3) one sentence performance summary"

## Syndicates Extracted
| Field | Beazley 623 | AEGIS 1225 |
|---|---|---|
| Year | 2023 | 2014 |
| GWP | 974,700 | 371,000 |
| Combined Ratio | 84% | 83.5% |
| Profit Before Tax | 180,800 | 60,500 |
| Currency | GBP 000s | GBP 000s |

## Risk Factors Found
### Beazley 623
1. Insurance/Underwriting Risk
2. Market Risk
3. Systemic Cyber Risk

### AEGIS 1225
1. Underwriting Risk
2. Reserving Risk
3. Credit Risk

## What Worked
- Claude extracted all fields in under 60 seconds
- NULL flagged correctly for missing fields

## What Needs Improvement
- Currency units inconsistent across reports
- nep_000s NULL in some reports — refine prompt

## Time Comparison
| Method | Time |
|---|---|
| Manual PDF reading | 25+ minutes |
| Claude extraction | Under 60 seconds |

## Tomorrow — Day 6
- Speed test: extract full table in under 60 seconds
- Build Lloyd's Prompt Library
