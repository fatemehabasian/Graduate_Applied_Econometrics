

# Government Expenditure, Income Level, and Their Impact on Reducing Child Mortality

## Overview

This repository contains the code and report for a project that investigates the impact of income levels and government expenditure on health in reducing child mortality in developing countries. The analysis uses data from 36 Sub-Saharan African countries over a ten-year period (2010-2019), just before the COVID-19 pandemic. The study employs econometric techniques such as pooled OLS, robust regression, and instrumental variable (IV) approaches to address potential endogeneity issues and establish a closer causal relationship between income, public health spending, and child mortality.

## Project Structure

- **`Code.do`**: The Stata script used to conduct the econometric analyses, including data processing, model estimation (OLS, robust regression, and IV), and diagnostic tests.
- **`Report.pdf`**: The comprehensive report that details the research findings, including the literature review, data description, methodology, regression results, and policy implications.

## Data Sources

### World Development Indicators (WDI)
The primary data used in this project is sourced from the World Development Indicators (WDI) database of the World Bank. The WDI provides extensive data on economic and social indicators, which are essential for analyzing trends in child mortality, income levels, and government expenditure in the selected countries.

### World Governance Indicators (WGI)
Supplementary data is obtained from the World Governance Indicators (WGI) to control for institutional quality and governance factors that may influence the effectiveness of public expenditure on health outcomes.

## Project Description

### Research Objectives

The main objectives of this study are:
- To examine the relationship between income levels and child mortality in developing countries.
- To analyze the impact of public health expenditure on reducing child mortality.
- To address the potential endogeneity of income and public health spending through an instrumental variable approach.

### Methodology

- **Econometric Methods**:
  - **Pooled OLS Regression**: Used to estimate the impact of income and public health spending on child mortality, while controlling for other socio-economic factors.
  - **Robust Regression**: Applied to account for potential heteroskedasticity in the error terms and to provide more reliable estimates.
  - **Instrumental Variable (IV) Approach**: Gross capital formation and external balance on goods and services are used as instruments for GDP per capita and public health spending to correct for endogeneity.

### Key Findings

- **Income and Child Mortality**: Higher income levels are significantly associated with lower child mortality, suggesting that wealthier countries are better equipped to provide the necessary resources for child survival.
- **Public Health Expenditure**: The analysis indicates that increased public health spending has a modest impact on reducing child mortality, although the results are not always statistically significant.
- **Instrumental Variable Results**: The IV approach confirms the negative impact of income on child mortality, while the effect of public health spending remains less conclusive.

## How to Use

1. **Running the Code**:
   - Open the `Code.do` file in Stata to replicate the analysis. The script includes all necessary steps, from data processing to model estimation and diagnostic testing.

2. **Viewing the Report**:
   - The `Report.pdf` provides a comprehensive explanation of the research, including the theoretical background, empirical methods, and detailed discussion of the results.

## Conclusion

