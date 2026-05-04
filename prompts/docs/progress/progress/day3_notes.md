# Day 3 — Validation, Scoring & Conclusions

> **Goal:** Systematically validate every extracted data point against the source document, produce the final scorecard, and draw conclusions.

---

## 🗓️ Date
Day 3 of 3 — HSE LLM Comparison Study

---

## 🎯 Objective for Today

- Cross-check all extracted values against source document (pp. 67–69 primary; full document secondary)
- Score each data point: CORRECT / WRONG / PARTIAL / MISSING
- Calculate section-by-section and overall scores
- Produce validation PDF report
- Draw final conclusions

---

## 🔬 Validation Methodology

### Ground Truth Source
Primary: **Performance Data Table (pp. 67–69)** — the authoritative numeric data source in the report.
Secondary: **Narrative sections (pp. 1–66)** — for qualitative KPIs, programs, targets.

### Scoring Criteria

| Verdict | Definition |
|---------|-----------|
| ✅ CORRECT | Value, unit, year, and scope exactly match source |
| ❌ WRONG | Extracted value contradicts source (factual error) |
| 🟡 PARTIAL | Some but not all years / sub-categories extracted |
| ⬜ MISSING | KPI present in source but not extracted at all |
| ➖ N/A | KPI genuinely not present in source (correct NULL) |

### Total checkpoints: **225 data points** across 10 sections

---

## 📊 Validation Results by Section

### Section 1 — Report Metadata (12 points)

| Field | ChatGPT | Claude |
|-------|---------|--------|
| Report title | ✅ | ✅ |
| Company name | 🟡 (abbreviated) | ✅ |
| Period start | ✅ (ISO format) | ✅ |
| Period end | ✅ (ISO format) | ✅ |
| Publication date | 🟡 (month only, day missing) | ✅ |
| Report version | ✅ (NULL correct) | ✅ |
| Applicable standards | 🟡 (3 of 9 listed) | ✅ (all 9) |
| Third-party assurance | ✅ | ✅ |
| Assurance level | 🟡 (scope qualifier missing) | ✅ |
| Acquisition data coverage | ⬜ | ✅ |
| Data as-of dates | ⬜ | ✅ |
| GHG/energy caveat | ⬜ | ✅ |

**Score — ChatGPT: 4/12 | Claude: 12/12**

---

### Section 2 — Safety KPIs (42 points)

Key findings:
- ChatGPT extracted LTIR for 2024 and 2023 only — missed 2022, 2021, 2020 entirely
- ChatGPT extracted zero TRIR values despite all 15 rows being in the data table
- ChatGPT extracted zero FAR values
- ChatGPT extracted zero fatality counts (employees or contractors)
- ChatGPT extracted zero Process Safety Tier 1 counts

All data is clearly in the performance table on p.68 — this is not an ambiguous or hidden data point.

**Score — ChatGPT: 8/42 | Claude: 42/42**

Notable: Claude correctly identified the denominator difference — LTIR/TRIR are per 200,000 work hours while FAR is per 1,000,000 work hours. ChatGPT did not note this distinction.

---

### Section 3 — Health KPIs (9 points)

Both models correctly noted NULL for most health metrics (genuinely not in the source). Claude additionally extracted two qualitative items (biometric screening mention, well-being champions mention) that were in the report but not numerically quantified.

**Score — ChatGPT: 6/9 | Claude: 9/9**

---

### Section 4 — Environmental KPIs (45 points)

This was the section with the most dramatic gap.

**The critical error confirmed:**
Checked p.67 of source against ChatGPT's "SOx = 25%, NOx = 25%, VOC = 25%":

```
Source p.67 (actual values):
SOx emitted 2024: 0.05 million metric tons
NOx emitted 2024: 0.11 million metric tons  
VOC emitted 2024: 0.13 million metric tons

Source p.29 (narrative trend):
"From 2016 to 2024, total reportable emissions of VOCs, SOx, 
and NOx decreased by about 25%"
```

The 25% figure is a trend narrative. The model extracted it as if it were the emission quantity. This is the clearest evidence that the model was reading narrative text and did not access the structured data table.

Additional ChatGPT misses: all 10 freshwater rows, all 6 discharge rows, all 20+ spill rows, all 30+ waste rows, all 5 expenditure rows.

**Score — ChatGPT: 7/45 | Claude: 45/45**

---

### Section 5 — Incidents & Events (7 points)

ChatGPT returned entirely NULL for this section. Claude extracted all 6 recorded events/drills with full details (date, location, participants, outcome, status).

**Score — ChatGPT: 1/7 | Claude: 7/7**

---

### Section 6 — Regulatory & Compliance (14 points)

Second major factual error confirmed here — environmental fines.

```
Source p.67:
Environmental penalties, fines and settlements:
2024: 0.001 billion USD
2023: <0.001 billion USD
2022: 0.002 billion USD
2021: <0.001 billion USD
2020: <0.001 billion USD
```

ChatGPT showed NULL for all years. The data is explicitly in the performance table.

Also: ChatGPT listed only 4 regulatory standards vs. 20 that are mentioned throughout the report.

**Score — ChatGPT: 5/14 | Claude: 14/14**

---

### Section 7 — Targets & Commitments (17 points)

Third major error confirmed — water target conflation:

```
ChatGPT extracted (for Permian Basin water target):
Target Value: 500,000,000 pounds

Actual target (p.26):
">90% recycled produced water by 2030"
Current status: 87% (2024), up from 64% (2022)
```

The 500M lbs figure is from the advanced recycling capacity expansion — a completely separate program on a different page.

**Score — ChatGPT: 2/17 | Claude: 17/17**

---

### Sections 8, 9, 10 (79 combined points)

- **Section 8 (Programs):** ChatGPT listed 3 of 27 programs; PSMS named generically as "Workforce Safety Program"; WHC conservation described only as PNG rather than the full US+Canada program network.
- **Section 9 (Workforce):** Entire section NULL despite full 5-year diversity and training table on p.68.
- **Section 10 (Flags):** 8 of 24 applicable flags raised. All RESTATED, MULTI-YEAR, and portfolio-scope SCOPE UNCLEAR flags missed.

**Combined score — ChatGPT: 15/79 | Claude: 79/79**

---

## 🔍 Root Cause Analysis

### Why did ChatGPT miss the data table?

**Hypothesis confirmed:** The pattern of errors strongly suggests ChatGPT drew primarily from the Executive Summary (pp. 1–8) rather than the Performance Data Table (pp. 67–69).

Evidence:
1. The "25%" error only appears in narrative sections — not in the data table
2. The water target conflation: the $500M lbs figure appears in the Executive Summary snapshot on p.7, while the actual water target is in the body section on p.26
3. The 3 standards listed (IOGP, GRI, ISO 14001) are the ones mentioned in the introduction — the full list is distributed throughout the report
4. All correctly extracted values (LTIR 0.02, water 98%) are prominently featured in the Executive Summary narrative

**This suggests a positional bias** — the model gave more weight to content at the beginning of the document and either truncated or deprioritized the data table at pp. 67–69.

### Why did Claude succeed?

1. Treated the performance table as the authoritative source and extracted systematically
2. Cross-referenced narrative text with table values (e.g., flagged when Executive Summary rounded $199.9M to "$200M")
3. Maintained schema discipline throughout — every section fully populated regardless of whether values existed
4. Applied data quality flags proactively without being prompted to flag specific items

---

## 📈 Final Scorecard

| Section | ChatGPT | Claude | Gap |
|---------|---------|--------|-----|
| S1 — Metadata | 4/12 (33%) | 12/12 (100%) | 67pp |
| S2 — Safety | 8/42 (19%) | 42/42 (100%) | 81pp |
| S3 — Health | 6/9 (67%) | 9/9 (100%) | 33pp |
| S4 — Environment | 7/45 (16%) | 45/45 (100%) | 84pp |
| S5 — Incidents | 1/7 (14%) | 7/7 (100%) | 86pp |
| S6 — Regulatory | 5/14 (36%) | 14/14 (100%) | 64pp |
| S7 — Targets | 2/17 (12%) | 17/17 (100%) | 88pp |
| S8 — Programs | 2/27 (7%) | 27/27 (100%) | 93pp |
| S9 — Workforce | 5/28 (18%) | 28/28 (100%) | 82pp |
| S10 — Flags | 8/24 (33%) | 24/24 (100%) | 67pp |
| **TOTAL** | **48/225 (21%)** | **225/225 (100%)** | **79pp** |

### 🏆 Winner: Claude — all 10 sections

---

## 💡 Conclusions & Lessons Learned

### For AI users doing document extraction:

1. **Specify the data source explicitly.** Saying "extract from the performance data table on page 67" may significantly improve ChatGPT results. The model may not prioritise structured tables over narrative prose by default.

2. **Always validate extracted values against source tables.** A plausible-looking output can contain critical factual errors (as seen with the SOx/NOx/VOC values).

3. **Length ≠ completeness, but brevity can indicate shallowness.** ChatGPT's 3-page output vs. Claude's 14-page output was an early signal that something was missing.

4. **For compliance-critical use cases**, Claude's NULL discipline and data quality flagging make it significantly more reliable. An auditor needs to know what the model *couldn't find*, not just what it found.

5. **Test with known ground truth.** This study only worked because the source document had a clear, verifiable performance table. In cases without a structured table, validation is harder.

### For prompt engineers:

- Adding explicit instructions like "prioritise structured tables and data appendices over narrative text" may help models with positional bias
- The NULL mandate was the single most important rule — it made every omission visible
- Page citation requirements are invaluable for post-extraction validation

---

## ✅ Day 3 Outputs

- [x] 225-point validation table completed
- [x] 3 critical factual errors confirmed in ChatGPT output
- [x] Root cause analysis documented
- [x] Final scorecard produced
- [x] Validation PDF report generated → [`../validation/HSE_Validation_Report.pdf`](../validation/)
- [x] Study conclusions written

---

## ← Back: [Day 2 — Running the Extractions](./day2-extractions.md) | [README](../README.md)
