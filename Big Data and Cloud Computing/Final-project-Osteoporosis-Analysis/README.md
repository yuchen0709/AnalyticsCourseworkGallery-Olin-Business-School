### Executive Summary
This project analyzes adverse drug reactions (ADRs) among patients treated for osteoporosis using a large real-world dataset extracted from the FDA Adverse Event Reporting System (FAERS). The study investigates age-related differences in ADR severity and drug-specific associations with serious clinical outcomes such as hospitalization, disability, life-threatening events and death. Patient outcomes were summarized across four age groups and evaluated with a chi-square test of independence, revealing that age and ADR seriousness are significantly associated, with the highest serious-event rate observed in adults aged 75 and older. At the drug level, a 2×2 risk framework was applied to each active ingredient, yielding risk ratios and statistical significance metrics. Several ingredients—including morphine, loxoprofen sodium, potent bisphosphonates, and combination analgesics—demonstrated disproportionately high associations with severe ADRs. Together, the findings highlight both vulnerable patient subgroups and high-risk medications within osteoporosis therapy. The study underscores the need for targeted monitoring, particularly for older adults and users of specific high-risk drugs.

### Dataset
The dataset used in this study was derived from the [U.S. Food and Drug Administration’s (FDA) Adverse Event Reporting System (FAERS)](https://www.fda.gov/drugs/drug-approvals-and-databases/fda-adverse-event-reporting-system-faers-database), filtered specifically for reports in which osteoporosis was listed as the drug indication. FAERS reports document instances in which patients experience adverse reactions to medications and include patient demographic information, drug details, dosage, adverse event descriptions, and relevant dates. Each row in the dataset corresponds to a single adverse event incident.

### Tools and Methodologies
- Linux for Interact with cloud server
- HDFS for distributed storage of the raw dataset.
- PySpark for large-scale data wrangling, aggregation, and risk computation.
- Pandas + SciPy for χ² statistical testing.
- Seaborn / Matplotlib for generating visualizations.


### Data Cleaning
- Removed date, dosage, indication, reaction, rechallenge/dechallenge, gender, age and caseid columns
- Transformed prod_ai and drug name columns to more accurately state the drug’s active ingredient
- Standardized age groups w/ 0-2 year olds as infants, 2-8 years as children, 12-18 years as teenagers, 18-60 years as adults and over 60 years as elders
- Converted all patient weights to kilograms
- Re-labeled dose forms as either oral, inhalation, transdermal, topical, IV, IM or SQ
- Replaced abbreviations of pt’s country of origin and outcome code with full name

### Key findings
Age-Related Conclusions
- Serious-event proportions differ modestly but meaningfully across age groups:
-- 65–74: ~57.8% serious
-- 75+: ~60.3% serious (highest of all groups)
- Age and serious outcomes are not independent.
-- A 4×2 chi-square test shows a strong association (χ² ≈ 252.7, df = 3, p ≈ 1.7×10⁻⁵⁴).
- Practical implication:
-- Older adults—especially those 75+—should be prioritized for monitoring and follow-up due to their elevated likelihood of serious ADRs.
-- These conclusions should be interpreted with the usual caution that comes with spontaneous reporting data (e.g., under-reporting, confounding).



Drug-Related Conclusions
The most prominent ingredient-level safety signals include:
- Morphine (RR = 1.65, p < 1×10⁻¹⁵)
-- Strongest association with serious outcomes despite only 106 serious cases; suggests disproportionate severity in the reports.
- Loxoprofen sodium (RR = 1.65, p < 1×10⁻¹⁴)
-- High risk ratio consistent with NSAID-related complications in an older patient population.
- Bisphosphonate comparison therapies
-- Zoledronate vs. risedronate and zoledronic acid vs. alendronate
-- Both show elevated RRs (≈1.65, p < 1×10⁻¹²), aligning with known risks of potent bisphosphonates (e.g., renal issues, hypocalcemia).
- Combination analgesics (e.g., hydrocodone/APAP, RR ≈ 1.65, p ≈ 1×10⁻¹¹)
-- Reinforces a clustering of high-RR analgesics, suggesting pain-management regimens may meaningfully elevate serious-event risk.
- Across nearly all identified ingredients, p-values far below 1×10⁻⁶ indicate robust associations, not artifacts of large sample size.
-- Datasets where non-serious cases = 0 but serious cases > 0 produced artificially normalized RRs (≈1), but p-values still captured genuine disproportionality.

