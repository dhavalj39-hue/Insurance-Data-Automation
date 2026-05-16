# Day 16 — Drill-Through: Managing Agent → Syndicate Detail

## What I Built
Set up drill-through navigation from Page 1 to a dedicated 
Profit Before Tax detail page, filtered by managing agent.

## How It Works
1. Page 1 has bar charts showing syndicate performance
2. Right-click any managing agent bar → Drill through → 
   Profit Before Tax by Managing Agent
3. Page 2 opens filtered to that agent's data only
4. Power BI adds a "Back to report" button automatically

## Page 2 Setup
- Y-axis: managing_agent
- X-axis: Sum of pbt_000s (Profit Before Tax in £000s)
- Table below showing: managing_agent + Sum of pbt_000s
- Drill through field: managing_agent

## Results Visible in Dashboard
| Managing Agent | Profit Before Tax (£000s) |
|---|---|
| Beazley Furlonge Limited | 180,800 |
| ACE Underwriting Agencies Ltd | 154,645 |
| AEGIS Managing Agency Ltd | 60,500 |
| Antares Managing Agency Limited | 18,386 |
| RiverStone Managing Agency Limited | 17,029 |

## What I Learned
- Drill-through field must be in the Drill through well on 
  the destination page
- managing_agent on the Y-axis of Page 1 charts triggers 
  the drill-through option on right-click
- "Back to report" button appears automatically — 
  no manual setup needed

## Screenshot
day-16-drill-through.png
