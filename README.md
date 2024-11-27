# SfDS Project 24.25 - [Migration | R]

Work developed in the Statistics for Data Science course of the Master's in Data Science and Advanced Analytics at NOVA IMS.

> This project aims .....

<br>

#### Group [37]

  - André Silvestre, 20240502
  - Umeima Mahomed, 20240543


----

<br><br>

### Analysis of the Data Description and Variable Properties

Based on the provided summary, we can infer important characteristics of the **Missing Migrants Project dataset**. This analysis guides the formulation of research questions, considering the types of variables, the presence of missing data, imbalance, and the nature of the project requirements. Here's an overview:

---

### Key Characteristics of the Dataset:
1. **Structure**:
   - 17,474 rows and 25 columns.
   - **16 character variables** (categorical or textual) and **9 numeric variables** (quantitative).

2. **Imbalance**:
   - Numeric variables like **"Number of Dead"**, **"Minimum Estimated Number of Missing"**, and **"Number of Survivors"** are heavily skewed (most values near zero, with a few extreme outliers).
   - The character variables (e.g., **"Region of Incident"**, **"Migration Route"**) have varying unique values, indicating potential sparsity or imbalance in their distributions.

3. **Missing Data**:
   - Variables like **"Minimum Estimated Number of Missing"** (9.69% complete rate), **"Migration Route"** (85% complete rate), and **"Number of Survivors"** (15.8% complete rate) have substantial missingness, which could complicate analyses.

4. **Potential for Analysis**:
   - **Continuous dependent variables**: **"Total Number of Dead and Missing"**, **"Number of Survivors"**, and potentially **"Number of Females/Males/Children"**.
   - **Categorical predictors**: Region, route, causes of death, etc.
   - Time-series aspects with **"Incident Year"**.

---

### Research Questions and Considerations

#### **Cross-Sectional Data**
Focus on a single snapshot or aggregation, exploring relationships without temporal trends.

##### Possible Questions:
1. **What factors influence the total number of deaths and missing persons in migration incidents?**
   - Dependent Variable: **"Total Number of Dead and Missing"**.
   - Independent Variables: **"Region of Incident"**, **"Cause of Death"**, **"Migration Route"**, **"Country of Incident"**.
   - Justification: Identify high-risk regions and causes for policy recommendations.
   - Challenges:
     - Missing data in "Migration Route".
     - Imbalance in deaths (most incidents have a small number of deaths).

3. **Do regions with harsher causes of death (e.g., environmental factors) report higher survivor rates?**
   - Dependent Variable: **"Number of Survivors"**.
   - Independent Variables: **"Cause of Death"**, **"Region of Incident"**.
   - Justification: Evaluate the survivability of incidents under extreme conditions.
   - Challenges:
     - Survivors are underreported (only 15.8% completeness).
     - Survivors might not correlate with all causes of death.

---

#### **Panel Data**
Leverage the temporal aspect to analyze trends or causal relationships over time and across regions.

##### Possible Questions:
1. **How have the total deaths and missing persons changed over time in different regions?**
   - Dependent Variable: **"Total Number of Dead and Missing"**.
   - Independent Variables: **"Year"**, **"Region of Incident"**, **"Cause of Death"**.
   - Justification: Identify regional patterns or trends for preventive measures.
   - Challenges:
     - Missingness and imbalance in certain regions or years.

2. **What is the temporal trend in incidents involving children across regions?**
   - Dependent Variable: **"Number of Children"**.
   - Independent Variables: **"Year"**, **"Region of Incident"**, **"Migration Route"**.
   - Justification: Examine if risks to children have increased in certain routes over time.
   - Challenges:
     - Missingness and potential data sparsity for children.

3. **Has the quality of reporting (Source Quality) improved the completeness of data over time?**
   - Dependent Variable: **"Source Quality"** (numeric rating).
   - Independent Variables: **"Year"**, **"Region of Incident"**, **"Information Source"**.
   - Justification: Understand if reporting efforts have enhanced data reliability.
   - Challenges:
     - Correlation between "Source Quality" and other variables might be weak.

---

### Key Considerations for Model Selection:
1. **Missing Data**:
   - For substantial missingness (e.g., "Number of Survivors"), imputation or exclusion might be necessary.
   - Analyze the patterns of missing data—e.g., is missingness systematic (related to regions or causes)?

2. **Imbalance**:
   - Variables like "Number of Dead" and "Minimum Estimated Number of Missing" are highly skewed, requiring transformation (e.g., log transformation) or robust regression techniques.

3. **Temporal Trends**:
   - For panel data, fixed effects (FE) or random effects (RE) models can account for unobserved heterogeneity across regions or time.

4. **Variable Interactions**:
   - Consider potential interactions between predictors, e.g., the relationship between "Cause of Death" and "Region of Incident."
