

# Determinants of Homeownership Among Urban Households in Iran

## Overview

This repository contains the code and report for a study that investigates the determinants of homeownership among urban households in Iran. The study employs **logistic regression** and **probit regression** models—both of which are commonly used econometric methods for binary outcomes—to analyze the impact of various socio-economic factors on the likelihood of owning a home. By utilizing data from the Household Income and Expenditure Survey conducted by the Iranian Statistical Center in 2021 (1400 in the Iranian calendar), the research provides insights into the key factors influencing homeownership in urban areas of Iran.

## Project Structure

- **`Code.do`**: The Stata script that implements the logistic and probit regression analyses. This script processes the data, estimates the models, and generates relevant outputs.
- **`Report.pdf`**: The comprehensive report detailing the research findings, including the literature review, methodology, regression results, and policy implications.

## Project Description

### Research Objectives

The key objectives of this study are:
- To examine the influence of household characteristics, such as size, income, and employment status, on the likelihood of owning a home.
- To explore the impact of education level, marital status, and other demographic factors on homeownership.
- To analyze regional variations in homeownership rates, particularly focusing on major metropolitan areas and Tehran.
- To evaluate the effects of government subsidies and car ownership on the probability of homeownership.

### Methodology

- **Data Source**: The study uses data from the Household Income and Expenditure Survey for urban households in Iran, collected in 2021.
- **Econometric Methods**: The study employs **logistic regression** and **probit regression** models to estimate the probability of homeownership. These models are appropriate for binary dependent variables, allowing us to quantify the impact of various factors on the likelihood that a household owns a home. 
  - **Logistic Regression**: This model assumes that the probability of homeownership follows a logistic distribution.
  - **Probit Regression**: This model assumes that the probability of homeownership follows a cumulative normal distribution.
  - **Marginal Effects**: After estimating the models, marginal effects are calculated to provide more intuitive interpretations of the regression coefficients.

### Key Findings

- **Income and Subsidies**: Higher household income and receipt of government subsidies significantly increase the likelihood of homeownership.
- **Education**: Surprisingly, higher education levels are generally associated with a lower probability of homeownership, possibly due to the delayed entry into the workforce and the higher opportunity costs associated with pursuing higher education.
- **Regional Factors**: Residing in Tehran or other major metropolitan areas significantly reduces the probability of homeownership, likely due to higher property prices and the cost of living in these regions.
- **Household Size**: Larger household size is associated with a lower probability of homeownership, potentially due to the higher financial burdens and living expenses associated with supporting more family members.

## How to Use

1. **Running the Code**:
   - Open the `Code.do` file in Stata to replicate the analysis. The script includes data processing, model estimation, and diagnostic checks.

2. **Viewing the Report**:
   - The `Report.pdf` provides a detailed explanation of the research, including the theoretical framework, empirical methods, and a comprehensive discussion of the results.

## Conclusion

This project sheds light on the socio-economic factors influencing homeownership among urban households in Iran. The findings, derived from logistic and probit regression models, highlight the importance of income and regional housing market conditions in determining homeownership. These insights can inform policy initiatives aimed at improving housing affordability and accessibility, particularly in high-cost urban areas like Tehran.

