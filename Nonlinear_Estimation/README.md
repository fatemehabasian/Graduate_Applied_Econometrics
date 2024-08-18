
# Fertility Size Decision in Iran: Evidence from Household Income Expenditure Survey

## Overview

This repository contains the code and report for a project that investigates the factors influencing fertility size decisions in Iran. The study utilizes data from the Household Income Expenditure Survey (HIES) and employs econometric models such as Poisson regression and multinomial logit regression to analyze how household income, educational levels, and other socio-economic factors affect the number of children in Iranian households.

## Project Structure

- **`Code.do`**: The Stata script used to conduct the econometric analyses, including data processing, model estimation, and interpretation of results.
- **`Report.pdf`**: The detailed report documenting the research findings, including a literature review, theoretical framework, data description, empirical strategy, results, and policy implications.

## Project Description

### Research Objectives

The key objectives of this study are:
- To analyze the impact of household income and educational attainment on fertility decisions.
- To explore differences in fertility size between urban and rural households.
- To investigate how factors such as age, partner activity, and regional differences influence the number of children in a household.

### Methodology

- **Data Source**: The analysis is based on data from the Household Income Expenditure Survey (HIES) for the year 1400 (2021/2022), which provides comprehensive information on household income, expenditures, and various socio-economic characteristics across Iran.
  
- **Econometric Methods**:
  - **Poisson Regression with BHHH Algorithm**: This method is used to model count data, specifically the number of children in a household, considering factors like income, education, and age.
  - **Multinomial Logit Regression**: This model is employed to categorize households based on the number of children and to estimate the probability of each category based on the same explanatory variables.

### Key Findings

- **Age**: The study finds that the age of the husband significantly negatively impacts the number of children, indicating that older couples tend to have fewer children.
- **Education**: Higher education levels for both the household supervisor and the partner are associated with a lower number of children, reflecting the importance of educational attainment in fertility decisions.
- **Income**: While higher household income is associated with a slightly higher number of children, the effect is minimal, suggesting that income plays a less significant role compared to education and age.
- **Urban vs. Rural Differences**: The study highlights that rural households generally have more children than urban households, underscoring the importance of geographical context in fertility decisions.

## How to Use

1. **Running the Code**:
   - Open the `Code.do` file in Stata to replicate the analysis. The script includes the necessary steps for data preparation, model estimation, and generating results.

2. **Viewing the Report**:
   - The `Report.pdf` provides a comprehensive explanation of the research, including the theoretical background, empirical methods, and detailed discussion of the results.

