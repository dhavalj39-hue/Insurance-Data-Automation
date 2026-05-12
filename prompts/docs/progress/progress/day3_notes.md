# Day 3 — Validation, Scoring & Conclusions

> **Goal:** Systematically validate every extracted data point against the source document, produce the final scorecard, and draw conclusions.

---

## 🗓️ Date
Day 3 of 3 — Lloyd's Syndicate LLM Comparison Study

---

## 🎯 Objective for Today

- Cross-check all extracted values against source document (P&L Account, Balance Sheet primary; Strategic Report and Notes secondary)
- Score each data point: CORRECT / WRONG / PARTIAL / MISSING
- Calculate field-by-field and overall scores
- Produce validation scorecard
- Draw final conclusions

---

## 🔬 Validation Methodology

### Ground Truth Source
Primary: **Profit & Loss Account (pages 7–8) and Balance Sheet (pages 9–10)** — the authoritative numeric data sources in the report.
Secondary: **Strategic Report (pages 3–4) and Notes to the Accounts (pages 10–23)** — for qualitative KPIs, narrative context, and supporting data.

### Scoring Criteria

| Verdict | Definition |
|---|---|
| ✅ CORRECT | Value, unit, year, and source exactly match primary statement |
| ❌ WRONG | Extracted value contradicts source (factual error) |
| 🟡 PARTIAL | Value correct but page reference or confidence rating inaccurate |
| ⬜ MISSING | Field present in source but not extracted |
| ➖ N/A | Field genuinely not present in source (correct NULL) |

### Total checkpoints: **44 data points** across Part 1 (11 fields × 4 attributes) + Part 2 (3 qualitative sections)

---

## 📊 Validation Results — Part 1: Structured Financial Data

### Field 1 — Syndicate Number (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ 1225 | ✅ 1225 |
| Currency Unit | ✅ NULL correct | ✅ NULL correct |
| Page Reference | ✅ Page 2 | ✅ Page 2 |
| Confidence | ✅ High | ✅ High |

**Score — ChatGPT: 4/4 | Claude: 4/4**

---

### Field 2 — Managing Agent Name (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ Correct | ✅ Correct |
| Currency Unit | ✅ NULL correct | ✅ NULL correct |
| Page Reference | 🟡 Page 29 (Admin/Notes — secondary) | ✅ Page 27 (Administration section) |
| Confidence | ✅ High | ✅ High |

**Score — ChatGPT: 3/4 | Claude: 4/4**

> ⚠️ ChatGPT cited page 29 — this is within the Notes section. Page 27 is the dedicated Administration page where the Managing Agent is formally listed. Minor but relevant in an audit context.

---

### Field 3 — Year of Account (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ 2014 | ✅ 2014 |
| Currency Unit | ✅ NULL correct | ✅ NULL correct |
| Page Reference | ✅ Page 2 | ✅ Page 2 |
| Confidence | ✅ High | ✅ High |

**Score — ChatGPT: 4/4 | Claude: 4/4**

---

### Field 4 — Gross Written Premium (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ £371.0m | ✅ £371.0m |
| Currency Unit | ✅ £m | ✅ £m |
| Page Reference | ⚠️ Page 5 (Strategic Report — secondary) | ✅ Page 7 (P&L Statement — primary) |
| Confidence | ✅ High | ✅ High |

**Score — ChatGPT: 3/4 | Claude: 4/4**

> ⚠️ Both pages carry the same value, but page 5 is the Strategic Report narrative. Page 7 is the primary P&L statement. The prompt explicitly requires primary statement references.

---

### Field 5 — Net Written Premium (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ £307.0m | ✅ £307.0m |
| Currency Unit | ✅ £m | ✅ £m |
| Page Reference | ❌ Page 6 (incorrect — no such standalone page for NWP) | ✅ Page 7 (P&L Statement) |
| Confidence | ❌ Medium (incorrectly low — value directly stated) | ✅ High |

**Score — ChatGPT: 2/4 | Claude: 4/4**

> ❌ Two errors on one field: wrong page reference AND under-stated confidence. Net Written Premium is explicitly stated on the P&L — High confidence is correct.

---

### Field 6 — Net Claims Incurred (4 points) ⭐ Critical Field

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ❌ **(£131.4m) — WRONG YEAR** | ✅ **(£138.4m) — correct 2014 value** |
| Currency Unit | ✅ £m | ✅ £m |
| Page Reference | ✅ Page 7 | ✅ Page 7 |
| Confidence | ✅ High | ✅ High |

**Score — ChatGPT: 3/4 | Claude: 4/4**

> ❌ **Critical error confirmed.** Checked P&L Statement page 7 directly:
> ```
> Claims incurred, net of reinsurance — 2014: (138.4)
> Claims incurred, net of reinsurance — 2013: (131.2)
> ```
> ChatGPT extracted **(£131.4m)** — close to but not exactly matching the 2013 comparative of (£131.2m), suggesting a misread of the prior-year column. In a regulatory submission or audit, submitting a prior-year figure as current-year data constitutes a **material misstatement.**

---

### Field 7 — Net Operating Expenses (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ (£108.0m) | ✅ (£108.0m) |
| Currency Unit | ✅ £m | ✅ £m |
| Page Reference | ✅ Page 7 | ✅ Page 7 |
| Confidence | ✅ High | ✅ High |

**Score — ChatGPT: 4/4 | Claude: 4/4**

---

### Field 8 — Profit or Loss Before Tax (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ £60.5m | ✅ £60.5m |
| Currency Unit | ✅ £m | ✅ £m |
| Page Reference | ✅ Page 8 | ✅ Page 8 |
| Confidence | ✅ High | ✅ High |

**Score — ChatGPT: 4/4 | Claude: 4/4**

---

### Field 9 — Combined Ratio (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ 83.5% | ✅ 83.5% |
| Currency Unit | ✅ % | ✅ % |
| Page Reference | ✅ Page 5 | ✅ Page 5 |
| Confidence | ✅ High | ✅ High |

**Score — ChatGPT: 4/4 | Claude: 4/4**

---

### Field 10 — Total Assets (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ £808.6m | ✅ £808.6m |
| Currency Unit | ✅ £m | ✅ £m |
| Page Reference | ✅ Page 9 | ✅ Page 9 |
| Confidence | ✅ High | ✅ High |

**Score — ChatGPT: 4/4 | Claude: 4/4**

---

### Field 11 — Members' Funds (4 points)

| Attribute | ChatGPT | Claude |
|---|---|---|
| Value | ✅ £105.6m | ✅ £105.6m |
| Currency Unit | ✅ £m | ✅ £m |
| Page Reference | ⚠️ Page 23 (Notes — reconciliation table, secondary) | ✅ Page 10 (Balance Sheet — primary) |
| Confidence | ⚠️ Medium (incorrectly low — directly stated on Balance Sheet) | ✅ High |

**Score — ChatGPT: 2/4 | Claude: 4/4**

> ⚠️ Same pattern as Net Written Premium — ChatGPT found the value in the Notes first rather than tracing to the Balance Sheet. Confidence rated Medium despite the value being unambiguously stated.

---

## 📊 Validation Results — Part 2: Qualitative Analysis

### A. Classes of Business

| Criterion | ChatGPT | Claude |
|---|---|---|
| Source consistency | ❌ Mixed — pulled from both Strategic Report (page 5) and Segmental Analysis Note (page 16) | ✅ Single source — Segmental Analysis Note (page 16) |
| Taxonomy accuracy | ❌ "Casualty" and "Property" are portfolio mix % categories, not insurance classes | ✅ All entries are insurance class labels |
| Completeness | ⚠️ 6 items listed but 2 are from wrong framework | ✅ 5 items, all from correct framework |

**Score — ChatGPT: 1/3 | Claude: 3/3**

> ❌ ChatGPT mixed two classification frameworks in a single list:
> - **"Casualty" (32%) and "Property" (68%)** — these are portfolio split categories from the Strategic Report page 5, expressed as percentage weights
> - **"Marine, aviation and transport", "Fire and other damage to property", "Third party liability"** — these are insurance class labels from the Segmental Analysis note page 16
>
> These are fundamentally different taxonomies. Presenting them together would mislead any downstream portfolio or regulatory analysis.

---

### B. Top 3 Risk Factors

| Criterion | ChatGPT | Claude |
|---|---|---|
| Risk 1 — Identified correctly | ✅ Underwriting risk | ✅ Underwriting risk |
| Risk 1 — Supporting detail | ❌ Label only | ✅ Mechanisms explained (premium insufficiency, catastrophe aggregation) |
| Risk 2 — Identified correctly | ✅ Claims reserves risk | ✅ Claims reserves risk |
| Risk 2 — Supporting detail | ❌ Label only | ✅ Includes £3.3m profit sensitivity figure from Notes |
| Risk 3 — Identified correctly | ✅ Credit risk | ✅ Credit risk |
| Risk 3 — Supporting detail | ❌ Label only | ✅ Counterparty detail — investment portfolio + reinsurance debtors |

**Score — ChatGPT: 3/6 | Claude: 6/6**

---

### C. Performance Summary

| Criterion | ChatGPT | Claude |
|---|---|---|
| Profit figure cited | ❌ Not mentioned | ✅ £60.5m stated |
| Year reference | ❌ No year context | ✅ "ninth successive year" included |
| Investment income driver | ❌ Not mentioned | ✅ Improved investment returns cited |
| Combined ratio cited | ⚠️ Referenced generically | ✅ 83.5% stated explicitly |
| Word count within 25-word limit | ✅ 20 words | ✅ 25 words |

**Score — ChatGPT: 2/5 | Claude: 5/5**

---

## 🔍 Root Cause Analysis

### Why did ChatGPT make errors on specific fields?

**Hypothesis confirmed:** The pattern of errors points to two distinct failure modes:

**Failure Mode 1 — Year-column discipline**
The P&L Statement and Balance Sheet both present 2014 and 2013 figures side by side in adjacent columns. ChatGPT extracted the 2013 comparative value for Net Claims Incurred instead of the 2014 current year value. This suggests the model did not anchor to the correct column header before reading down the rows.

```
P&L Page 7 — two-column layout:
                              2014 £m    2013 £m
Claims incurred net of RI    (138.4)    (131.2)
                                ↑           ↑
                           Claude read  ChatGPT read
```

**Failure Mode 2 — Source hierarchy compliance**
For GWP, Net Written Premium, and Members' Funds, ChatGPT extracted values from whichever section it encountered first — the Strategic Report or Notes — rather than tracing to the primary P&L or Balance Sheet. This also explains the under-stated Medium confidence ratings: the model was less certain because it was not reading from the primary statement.

**Failure Mode 3 — Taxonomy conflation (Part 2)**
ChatGPT pulled classification terms from multiple sections without recognising they belonged to different frameworks. "Casualty/Property" (Strategic Report, portfolio weights) and "Marine, aviation and transport" (Segmental Analysis, insurance classes) are not interchangeable.

### Why did Claude succeed across all fields?

1. Consistently traced values to primary financial statements (P&L and Balance Sheet) before accepting secondary sources
2. Applied correct year-column discipline throughout the two-column P&L and Balance Sheet tables
3. Calibrated confidence ratings to reflect source quality — High only when value was directly and unambiguously stated in a primary statement
4. Drew qualitative analysis from a single, authoritative source per section rather than mixing across sections
5. Included quantitative context in qualitative fields (£3.3m sensitivity, ninth successive year, 83.5% combined ratio)

---

## 📈 Final Scorecard

### Part 1 — Structured Financial Data

| Field | Max Points | ChatGPT | Claude |
|---|---|---|---|
| Syndicate Number | 4 | 4 (100%) | 4 (100%) |
| Managing Agent | 4 | 3 (75%) | 4 (100%) |
| Year of Account | 4 | 4 (100%) | 4 (100%) |
| Gross Written Premium | 4 | 3 (75%) | 4 (100%) |
| Net Written Premium | 4 | 2 (50%) | 4 (100%) |
| **Net Claims Incurred** | **4** | **3 (75%) ❌ value wrong** | **4 (100%)** |
| Net Operating Expenses | 4 | 4 (100%) | 4 (100%) |
| Profit Before Tax | 4 | 4 (100%) | 4 (100%) |
| Combined Ratio | 4 | 4 (100%) | 4 (100%) |
| Total Assets | 4 | 4 (100%) | 4 (100%) |
| Members' Funds | 4 | 2 (50%) | 4 (100%) |
| **Part 1 Total** | **44** | **37 (84%)** | **44 (100%)** |

### Part 2 — Qualitative Analysis

| Section | Max Points | ChatGPT | Claude |
|---|---|---|---|
| Classes of Business | 3 | 1 (33%) | 3 (100%) |
| Top 3 Risk Factors | 6 | 3 (50%) | 6 (100%) |
| Performance Summary | 5 | 2 (40%) | 5 (100%) |
| **Part 2 Total** | **14** | **6 (43%)** | **14 (100%)** |

### Combined Overall

| | Max Points | ChatGPT | Claude |
|---|---|---|---|
| **TOTAL** | **58** | **43 (74%)** | **58 (100%)** |

### 🏆 Winner: Claude — all fields, all sections

---

## 💡 Conclusions & Lessons Learned

### For AI users doing financial document extraction:

1. **Specify the column explicitly.** In two-column financial statements (current year vs. prior year), instruct the model: *"Extract 2014 values only — ignore the 2013 comparative column."* This may prevent year-mix errors like the Net Claims Incurred failure.

2. **Specify source hierarchy.** Adding *"prefer primary financial statements (P&L, Balance Sheet) over Notes and narrative sections"* may improve page reference accuracy and confidence calibration.

3. **Always validate against the primary statement.** A value appearing in the Strategic Report and in the Notes does not mean it is the authoritative figure. The P&L and Balance Sheet are the ground truth.

4. **Length and precision signal depth.** Claude's more detailed output — with specific figures in qualitative sections and £3.3m sensitivity data in risk factors — reflected genuine document depth, not padding.

5. **For regulatory or audit use cases**, a single wrong-year figure (Net Claims Incurred) in a Lloyd's submission would constitute a material misstatement. The confidence rating of High on a factually wrong value makes it more dangerous, not less.

### For prompt engineers:

- Explicit column anchoring instructions ("2014 column only") are likely the single highest-value addition to this prompt for improving ChatGPT accuracy
- The source hierarchy rule ("primary statements over notes") should be included as a numbered instruction, not buried in general guidance
- Confidence ratings need a defined rubric — without one, models calibrate inconsistently (Medium vs. High for identical evidence quality)
- Page citation requirements remain essential: they expose source hierarchy violations immediately during validation

---

## ✅ Day 3 Outputs

- [x] 58-point validation completed across all fields and qualitative sections
- [x] 1 critical factual error confirmed in ChatGPT output (Net Claims Incurred — wrong year)
- [x] 2 source hierarchy violations confirmed (GWP page reference, Members' Funds page reference)
- [x] 2 confidence calibration errors confirmed (Net Written Premium, Members' Funds)
- [x] 1 taxonomy conflation error confirmed (Classes of Business — mixed frameworks)
- [x] Root cause analysis documented (3 distinct failure modes)
- [x] Final scorecard produced → [`../validation_scorecard.md`](../validation_scorecard.md)
- [x] Study conclusions written

---


