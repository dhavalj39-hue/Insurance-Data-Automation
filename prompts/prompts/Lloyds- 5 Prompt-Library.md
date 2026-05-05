# Lloyd's Prompt Library
**Built:** 05-05-2026

## Prompt 1 — Full Financial Extraction
**Tool:** Claude
"This is a Lloyd's syndicate annual report. Extract these fields 
into a table: syndicate number, managing agent, year of account, 
GWP, net written premium, gross claims paid, net claims incurred, 
net operating expenses, profit before tax, combined ratio, total 
assets, members funds. Note currency unit (£000s or £m). 
Write NULL if not found."

## Prompt 2 — Risk and Strategy
**Tool:** Claude
"Extract from this Lloyd's report:
(1) Main classes of business written
(2) 3 biggest risk factors
(3) One sentence performance summary
(4) Major events affecting results"

## Prompt 3 — Two Syndicate Comparison
**Tool:** Claude
"Compare these two Lloyd's syndicate reports in a table showing: 
GWP, combined ratio, profit before tax, main business class, 
biggest risk. Which performed better and why? Answer in 3 sentences."

## Prompt 4 — Data Validation
**Tool:** ChatGPT
"Check this extracted Lloyd's data table for errors:
[paste table]
- Are numbers reasonable for a Lloyd's syndicate?
- Does combined ratio match claims + expenses / premium?
- Flag anything missing or unusual."

## Prompt 5 — Executive Summary
**Tool:** Claude
"Summarise this Lloyd's syndicate report in 3 sentences:
Sentence 1 — Profitable? By how much?
Sentence 2 — What drove the result?
Sentence 3 — Biggest risk going forward?"

## Quick Reference
| Task | Prompt | Tool |
|---|---|---|
| Extract numbers | Prompt 1 | Claude |
| Extract risks | Prompt 2 | Claude |
| Compare syndicates | Prompt 3 | Claude |
| Validate data | Prompt 4 | ChatGPT |
| VP summary | Prompt 5 | Claude |

## Time Saved
| Task | Manual | With Prompt |
|---|---|---|
| Full extraction | 25 min | 60 seconds |
| Risk analysis | 15 min | 30 seconds |
| Comparison | 40 min | 2 minutes |
| VP summary | 20 min | 30 seconds |
