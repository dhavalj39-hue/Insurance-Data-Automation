# Day 17 — Slicers + Data Quality Page

**Date:** 22 May 2026
**Phase:** 3 — Power BI Advanced
**Day:** 17 of 30

---

## What I Did Today

Built Page 3 — Data Quality Dashboard with 3 working slicers.
Also created Performance Label as a DAX calculated column to use in slicer.

---

## Morning — Learned

- Slicers are filter buttons in Power BI
- Slicers only accept **Columns**, not **Measures**
- Difference between Measure and Column in Power BI:

| Type | What It Does | Works in Slicer? |
|------|-------------|-----------------|
| Measure | Aggregates many rows into one number (SUM, AVG) | ❌ No |
| Calculated Column | Stores one value per row | ✅ Yes |

---

## Afternoon — Built

### Page 3 — Data Quality Dashboard

Built the following on Page 3:

- Completeness rate KPI card
- Syndicates with missing data listed
- Quality trend over time chart
- 3 slicers for filtering all visuals

### 3 Slicers Added

| Slicer | Column Used |
|--------|------------|
| Year of Account | year_of_account |
| Managing Agent | managing_agent |
| Performance Label | Performance Label (DAX calculated column) |

---

## Problem I Solved Today

### Error: "Non-measure field required"

**What happened:**
Created Performance Label as a Measure — slicer gave error saying non-measure field required.

**Why it happened:**
I used [Average Combined Ratio] which is a Measure inside my SWITCH formula.
Power BI then created Performance Label as a Measure too.
Slicers cannot use Measures.

**First wrong attempt:**
```dax
Performance Label =
SWITCH(
    TRUE(),
    [Average Combined Ratio] < 95, "Strong",
    [Average Combined Ratio] < 100, "Marginal",
    [Average Combined Ratio] < 110, "Loss Making",
    [Average Combined Ratio] >= 110, "Significant Loss"
)
```
❌ This created a Measure — slicer rejected it

**Correct fix:**
```dax
Performance Label =
SWITCH(
    TRUE(),
    syndicate_clean[combined_ratio_pct] < 95,  "Strong Performer",
    syndicate_clean[combined_ratio_pct] < 100, "Marginal",
    syndicate_clean[combined_ratio_pct] < 110, "Loss Making",
    syndicate_clean[combined_ratio_pct] >= 110, "Significant Loss",
    "No Data"
)
```
✅ This created a Column — slicer accepted it

**Key difference:**
- Wrong: referenced [Average Combined Ratio] — a Measure
- Correct: referenced syndicate_clean[combined_ratio_pct] — the actual column
- Created under **Table tools → New Column** not New Measure

---

## Evening — Tested

Tested all 3 slicers together:

- ✅ Click Year of Account — all charts update
- ✅ Click Managing Agent — filters further
- ✅ Click Performance Label — shows only Strong / Marginal / Loss syndicates
- ✅ All 3 slicers work together at the same time

---

## Key Lesson From Today

> Measure vs Column is one of the most common Power BI mistakes.
> Always create Performance Labels and categories as Calculated Columns.
> If a slicer gives an error — check whether you used New Column or New Measure.

---

## GitHub File Saved

- Screenshot: `day-17-slicers.png` → `Phase-3-PowerBI/screenshots/`

---

## Tomorrow — Day 18

Build Page 4 — Executive Summary:

- 4 large KPI cards
- Manual text summary (no Copilot access — written myself)
- Top 3 Managing Agents by combined ratio
- Practice presenting out loud:
  *"Across X syndicates, Y% are profitable. Average combined ratio is Z%..."*

---

## Phase 3 Progress

| Day | Page | Status |
|-----|------|--------|
| 14 | First visuals — GWP bar chart, scatter chart | ✅ Done |
| 15 | KPI cards + DAX measures + conditional formatting | ✅ Done |
| 16 | Drill-through — managing agent to syndicate detail | ✅ Done |
| 17 | Slicers + Data Quality Page | ✅ Done |
| 18 | Executive Summary Page | 🔲 Tomorrow |
| 19 | Full rebuild revision | 🔲 Upcoming |
