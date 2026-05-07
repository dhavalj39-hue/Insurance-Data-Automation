# Lloyd's Syndicate Data Automation Portfolio

**Owner:** Dhaval Joshi
**Start Date:** 02-05-2026
**Target Role:** Lead Data Operations

---

## What This Project Demonstrates

I built a complete data pipeline for Lloyd's of London syndicate 
financial data using AI, SQL and Power BI.

This project proves I can:
- Extract structured financial data from complex PDFs in under 60 seconds
- Validate and query real Lloyd's syndicate data using SQL
- Find and fix data quality issues independently
- Build automated pipelines that replace manual work

---

## The Problem I Solved

**Before this project:**
Reading one Lloyd's syndicate PDF manually = 25+ minutes
Finding missing data = manual row by row checking
Comparing syndicates = copy paste between Excel files

**After this project:**
Extract full financial table from any PDF = under 60 seconds
Find all missing data across 7 syndicates = one SQL query
Compare any two syndicates = one Claude prompt

---

## Real Data I Am Working With

Lloyd's of London publishes annual syndicate reports for every 
syndicate in the Lloyd's market. These are real financial documents 
used by investors and regulators worldwide.

Fields I extract from every report:
- Gross Written Premium (GWP)
- Net Written Premium
- Net Claims Incurred
- Net Operating Expenses
- Profit or Loss Before Tax
- Combined Ratio
- Total Assets
- Members Funds

---

## Tools Used

| Tool | Purpose |
|---|---|
| Claude AI | Extract financial data from Lloyd's PDFs |
| ChatGPT | Validate extracted data for errors |
| DB Browser for SQLite | Write and run SQL queries |
| Power BI | Build performance dashboard |
| Power Automate | Automate alerts and email reports |
| GitHub | Document daily progress |

---

## 30 Day Progress

| Day | Phase | Focus | Status |
|---|---|---|---|
| 1-3 | AI First | First extraction attempts | Done |
| 4 | AI First | First Lloyd's PDF extraction | Done |
| 5 | AI First | Refined prompts + comparison | Done |
| 6 | AI First | Lloyd's Prompt Library built | Done |
| 7 | SQL | Database created + first queries | Done |
| 8 | SQL | WHERE filter queries | Done |
| 9 | SQL | NULL checks + data quality | Upcoming |
| 10 | SQL | GROUP BY analysis | Upcoming |
| 11 | SQL | JOIN — second table | Upcoming |
| 12 | SQL | CASE WHEN performance labels | Upcoming |
| 13 | SQL | Master quality check query | Upcoming |
| 14-19 | Power BI | Lloyd's dashboard | Upcoming |
| 20-26 | Automation | Full pipeline | Upcoming |
| 27-30 | Job Ready | VP presentation | Upcoming |

---

## Key Results So Far

- 7 Lloyd's syndicates loaded into SQL database
- Data quality issue found and fixed independently
  (combined_ratio_pct stored as TEXT — fixed using CAST)
- Extraction time reduced from 25 minutes to 60 seconds
- 6 core SQL queries written and tested on real data

---

## Folder Structure
Phase-1-AI-Tools/
        prompts/
            day-04-lloyds-extraction.md
            day-05-refined-prompts.md
            day-06-prompt-library.md
            Lloyds-Prompt-Library.md

    Phase-2-SQL/
        queries/
            day-07-first-queries.sql
            day-07-progress-notes.md
            day-08-where-queries.sql

    Phase-3-PowerBI/
        screenshots/

    Phase-4-Automation/
        pipeline/

    Phase-5-Job-Ready/
        system-summary.md
        presentation-script.md
        interview-answers.md
