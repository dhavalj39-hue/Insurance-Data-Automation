# Day 2 — Running the Extractions

> **Goal:** Submit the same prompt to both ChatGPT (GPT-4o) and Claude (Sonnet 4.6), collect raw outputs, and note first impressions before formal scoring.

---

## 🗓️ Date
Day 2 of 3 — Lloyd's Syndicate LLM Comparison Study

---

## 🎯 Objective for Today

- Submit identical prompt + source document to both models
- Collect and save raw outputs without editing
- Note immediate observations about approach differences
- Identify any obvious errors or omissions before formal validation

---

## ⚙️ Setup

### Both Models Received
- **Same prompt** — the full 11-field structured extraction schema + Part 2 qualitative analysis from Day 1
- **Same source document** — AEGIS London Syndicate 1225 Annual Report, Year Ended 31 December 2014 (PDF, 29 pages)
- **Same instruction framing** — "You are a senior financial and insurance data analyst specializing in Lloyd's syndicate reporting..."

### Key Variable
The only difference is the model — same input, same task, different AI.

---

## 🤖 ChatGPT Run — Observations

### What it produced
- **Output length:** ~2 pages equivalent
- **Time to complete:** Fast — response came quickly
- **Format adherence:** Mostly followed the table structure

### Immediate observations (before scoring)

**What looked right:**
- All 11 fields present in the table ✓
- Syndicate Number, Managing Agent, Year of Account all correct ✓
- GWP £371.0m correctly extracted ✓
- Net Written Premium £307.0m correct ✓
- Net Operating Expenses (£108.0m) correct ✓
- Profit £60.5m correct ✓
- Combined Ratio 83.5% correct ✓
- Total Assets £808.6m correct ✓
- Members' Funds £105.6m correct ✓

**What looked suspicious:**
- Net Claims Incurred showing **(£131.4m)** — this felt off, the number looked familiar but wrong for 2014
- Managing Agent page reference cited as page 29 (Notes/Admin) rather than a primary statement
- Members' Funds page reference cited as page 23 (Notes) rather than page 10 (Balance Sheet)
- Net Written Premium confidence marked as **Medium** — this is directly stated in the P&L, should be High
- Part 2 Classes of Business mixed two different classification frameworks (portfolio split + segmental)
- Performance summary contained no specific figures or year references

**First impression:**
The output looks clean and professional at a glance. Formatting is good. But the Net Claims figure triggered immediate concern — needed to go back to the source P&L to verify.

---

## 🤖 Claude Run — Observations

### What it produced
- **Output length:** ~3 pages equivalent
- **Time to complete:** Slightly slower — more thorough
- **Format adherence:** Followed schema precisely

### Immediate observations (before scoring)

**What looked right:**
- All 11 fields correctly populated ✓
- Net Claims Incurred correctly stated as **(£138.4m)** — matching P&L page 7 ✓
- All page references pointing to primary financial statements ✓
- GWP page reference correctly cited as page 7 (P&L), not page 5 (Strategic Report) ✓
- Members' Funds correctly sourced from Balance Sheet page 10 ✓
- All confidence ratings correctly calibrated as High ✓
- Part 2 Classes of Business drawn consistently from a single source (Segmental Analysis, page 16) ✓
- Performance summary cited specific figure (£60.5m), ninth successive year, and combined ratio ✓
- Risk factors included quantitative context (£3.3m claims reserve sensitivity) ✓

**Things I noted to verify:**
- Wanted to confirm Net Claims (£138.4m) directly on page 7 of PDF — confirmed ✓
- Verified that (£131.4m) in ChatGPT output matches 2013 comparative column — confirmed ✓

**First impression:**
Every number traces cleanly back to the correct page and the correct year. The qualitative section reads like someone who absorbed the whole report, not just the highlights page.

---

## 🔍 Side-by-Side First Look

| Observation | ChatGPT | Claude |
|---|---|---|
| Output length | ~2 pages | ~3 pages |
| Fields correctly extracted | 10 / 11 | 11 / 11 |
| Page references (primary statements) | 8 / 11 | 11 / 11 |
| Confidence ratings accurate | 9 / 11 | 11 / 11 |
| Correct reporting year data | ❌ (1 field wrong year) | ✅ All 2014 |
| Source hierarchy compliance | ⚠️ Partial | ✅ Full |
| Classes of Business consistency | ❌ Mixed taxonomy | ✅ Single source |
| Performance summary with figures | ❌ No figures cited | ✅ Figures cited |
| Risk factors with context | ❌ Labels only | ✅ With detail + sensitivity |

---

## ⚠️ Red Flags Identified Before Formal Scoring

### Red Flag 1 — ChatGPT Net Claims Incurred: Wrong Year
The value **(£131.4m)** for Net Claims Incurred triggered immediate concern. These are financial statements — the number should reflect 2014, not 2013. Checked source P&L page 7:

```
Net Claims Incurred — 2014:  (£138.4m)   ← correct value
Net Claims Incurred — 2013:  (£131.2m)   ← prior year comparative
```

ChatGPT extracted **(£131.4m)** — close to but not even exactly matching the 2013 comparative of (£131.2m), suggesting possible rounding or misread. Regardless, **the wrong column was read entirely.** This is a fundamental year-identification error.

> In an audit or regulatory filing context, a prior-year figure submitted as current-year data would constitute a material misstatement.

### Red Flag 2 — ChatGPT Page References: Secondary Sources Preferred
ChatGPT cited:
- GWP from **page 5** (Strategic Report) instead of **page 7** (P&L Statement)
- Members' Funds from **page 23** (Notes — reconciliation table) instead of **page 10** (Balance Sheet)

The prompt explicitly states: *"Prefer values from primary financial statements over notes."*
Both deviations indicate the model extracted from the first place it encountered the figure, rather than tracing to the primary statement.

### Red Flag 3 — ChatGPT Classes of Business: Mixed Taxonomy
Part 2 listed both:
- **"Casualty" and "Property"** — these are portfolio mix categories from the Strategic Report (page 5), expressed as percentages (32% / 68%)
- **"Marine, aviation and transport", "Fire and other damage to property", "Third party liability"** — these are segmental classes from the Notes (page 16)

These are two entirely different classification frameworks from two different sections of the report. Mixing them in a single list creates a taxonomy error that would mislead any downstream analysis.

---

## 💭 Day 2 Hypothesis Update

The pattern is clear: **ChatGPT appears to have read across multiple sections without anchoring to the correct year column**, while Claude consistently traced each value to the primary statement and the 2014 column specifically.

The Net Claims error is the strongest evidence — the 2013 comparative sits immediately adjacent to the 2014 figure in the P&L table. A careful reading of a two-column financial statement requires explicit year-column discipline. Claude applied this; ChatGPT did not.

The taxonomy error in Part 2 reinforces this: ChatGPT pulled terms from whichever section mentioned insurance classes first, rather than identifying the most authoritative classification source (the segmental analysis note).

---

## ✅ Day 2 Outputs

- [x] ChatGPT extraction collected
- [x] Claude extraction collected
- [x] 3 critical red flags identified in ChatGPT output
- [x] Side-by-side first impression documented
- [x] Root cause hypothesis formed (year-column discipline + source hierarchy compliance)

---


