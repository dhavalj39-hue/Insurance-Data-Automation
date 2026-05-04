# Day 2 — Running the Extractions

> **Goal:** Submit the same prompt to both ChatGPT (GPT-4o) and Claude (Sonnet 4.5), collect raw outputs, and note first impressions before formal scoring.

---

## 🗓️ Date
Day 2 of 3 — HSE LLM Comparison Study

---

## 🎯 Objective for Today

- Submit identical prompt + source document to both models
- Collect and save raw outputs without editing
- Note immediate observations about approach differences
- Identify any obvious errors or omissions before formal validation

---

## ⚙️ Setup

### Both Models Received
- **Same prompt** — the full 10-section HSE extraction schema from Day 1
- **Same source document** — ExxonMobil 2025 Sustainability Report (PDF, 71 pages)
- **Same instruction framing** — "You are a senior HSE data analyst..."

### Key variable
The only difference is the model — same input, same task, different AI.

---

## 🤖 ChatGPT Run — Observations

### What it produced
- **Output length:** ~3 pages equivalent
- **Time to complete:** Fast — response came quickly
- **Format adherence:** Mostly followed the table structure

### Immediate observations (before scoring)

**What looked right:**
- Section headers were present for all 10 sections ✓
- NULL was written in most empty fields ✓
- LTIR values for 2024 and 2023 appeared (0.02) ✓
- Lloyd's Register named as assurance provider ✓
- Water recycling 98% for Permian Basin ✓
- Advanced recycling 1B lbs capacity target ✓

**What looked suspicious:**
- SOx, NOx, and VOC all showing "25%" — something felt off here
- Section 4 was very thin — only about 9 rows total for the entire Environmental section
- Section 9 Workforce was entirely NULL across all fields
- Only 3 standards listed (IOGP, GRI, ISO 14001) when the prompt asked for all applicable ones
- Environmental fines all showing NULL
- Section 8 had only 3 programs listed vs. what I expected (~25+)

**First impression:**
The output *looks* structured and professional at a glance. The table formatting is clean. But it's shallow — headline numbers only, and the suspicious "25%" values for emissions needed checking.

---

## 🤖 Claude Run — Observations

### What it produced
- **Output length:** ~14 pages equivalent (significantly longer)
- **Time to complete:** Slower — much more thorough
- **Format adherence:** Followed schema very precisely

### Immediate observations (before scoring)

**What looked right:**
- All 10 sections fully populated
- Full 5-year time series (2020–2024) for every KPI
- Fatalities broken out by employees vs. contractors for each year
- TRIR with employee/contractor/total split across 5 years
- FAR with correct denominator (per 1,000,000 work hours vs. LTIR per 200,000)
- All 20 regulatory standards with individual compliance status
- All environmental fines correctly extracted ($1M, $2M, <$1M by year)
- 27 programs in Section 8 with investment amounts and outcomes
- Full workforce diversity and training data (5-year series)
- 48 data quality flags across all sections

**Things I noted to verify:**
- Several `<0.1` waste values — needed to confirm these were in the source
- NOx methodology change flag — needed to verify footnote 3 on p.69
- Denbury/Pioneer portfolio scope notes — needed to cross-check

**First impression:**
This is what I'd expect from a senior analyst who read the entire document carefully. The length was initially surprising but every section had genuine data behind it.

---

## 🔍 Side-by-Side First Look

| Observation | ChatGPT | Claude |
|-------------|---------|--------|
| Output length | ~3 pages | ~14 pages |
| Sections completed | 10/10 (but mostly NULL) | 10/10 (fully populated) |
| LTIR values extracted | 2/15 rows | 15/15 rows |
| TRIR extracted | 0 rows | 15 rows |
| Fatality data | 0 rows | 10 rows |
| Environmental KPIs (S4) | ~9 rows | ~55 rows |
| 5-year time series | Rarely | Always |
| Unit conversions | None | Shown for all non-SI values |
| Data quality flags | 8 flags | 48 flags |
| Page citations | Rarely | Every row |
| Standards listed | 3 | 9 |
| Programs listed (S8) | 3 | 27 |

---

## ⚠️ Red Flags Identified Before Formal Scoring

### Red Flag 1 — ChatGPT SOx/NOx/VOC Values
The values "25%" for SOx, NOx, and VOC triggered immediate concern. These are emission quantities — they should be in million metric tons. Checked source p.67:

```
SOx: 0.05 million metric tons (2024)
NOx: 0.11 million metric tons (2024)  
VOC: 0.13 million metric tons (2024)
```

The "25%" is from a completely different sentence on pp. 4 and 29:
> "From 2016 to 2024, total reportable emissions of VOCs, SOx, and NOx decreased by about 25%"

The model extracted the reduction percentage and applied it as the emission value. **This is a fundamental data identification error.**

### Red Flag 2 — ChatGPT Water Target
Section 7 showed the Permian Basin water target as "500,000,000 pounds" — this is the advanced recycling capacity target, not the water recycling target. Two completely different metrics had been conflated.

### Red Flag 3 — ChatGPT Fines All NULL
Environmental fines clearly visible on p.67 of the source document:

```
2024: 0.001 ($1M)
2023: <0.001 (<$1M)
2022: 0.002 ($2M)
2021: <0.001 (<$1M)
2020: <0.001 (<$1M)
```

All showing NULL in the ChatGPT output.

---

## 💭 Day 2 Hypothesis Update

The pattern is becoming clear: **ChatGPT appears to have read the Executive Summary (pp. 1–8) primarily**, while Claude reached the structured Performance Data Table (pp. 67–69).

This is a critical difference. The executive summary uses rounded, narrative figures and trend statements. The data table contains the precise 5-year time series that the prompt was asking for.

The 25% error is the clearest evidence of this — that figure only appears in the narrative sections as a qualitative trend description, not in the data table.

---

## ✅ Day 2 Outputs

- [x] ChatGPT extraction collected and saved → [`../extractions/chatgpt-output.md`](../extractions/chatgpt-output.md)
- [x] Claude extraction collected and saved → [`../extractions/claude-output.md`](../extractions/claude-output.md)
- [x] 3 critical red flags identified in ChatGPT output
- [x] Side-by-side first impression documented
- [x] Root cause hypothesis formed (Executive Summary vs. Data Table reading)

---

## ➡️ Next: [Day 3 — Validation & Scoring](./day3-validation.md)
