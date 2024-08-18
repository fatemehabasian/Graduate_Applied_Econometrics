
# Economic and Labor Analysis of Iran Using HIES and LFS Data

## Overview

This repository contains a series of econometric analyses using data from Iran's Household Income Expenditure Survey (HIES) and Labor Force Survey (LFS). The analyses focus on various socio-economic issues, including household expenditures, labor market participation, housing conditions, and inequality in Iran. These projects utilize advanced econometric techniques to derive insights into the economic and labor dynamics within the country.

## Data Sources

### Household Income Expenditure Survey (HIES)
The Household Income Expenditure Survey (HIES) is a comprehensive survey that collects detailed information on household income, expenditure, and consumption patterns across Iran. Conducted annually by the Iranian Statistical Center, the HIES covers a wide array of socio-economic indicators, making it a vital resource for understanding living standards, income distribution, and economic well-being in Iran.

### Labor Force Survey (LFS)
The Labor Force Survey (LFS) is another critical dataset used in this repository. It provides detailed information on the employment status, participation rates, and demographic characteristics of Iran's labor force. The LFS data is essential for analyzing labor market trends, including unemployment rates, workforce participation across different demographic groups, and sectoral employment patterns.

## Project Structure

- **`Code.do`**: Stata scripts for data preparation, analysis, and visualization related to various socio-economic topics.
- **`MDBToDTA.do`**: Script used for converting database files into Stata format (`.dta`), facilitating further analysis.
- **`Report.pdf`**: Detailed reports documenting the findings from each project, including background, methodology, results, and policy implications.

## Projects Overview

### 1. Labor Market Participation and Unemployment Analysis
- **Objective**: Analyze the participation and unemployment rates in Iran across different demographic groups (by gender, age, and urban vs. rural areas).
- **Methods**: Descriptive statistics, weighted calculations for accurate representation of population segments, and visualizations to compare participation and unemployment rates.
- **Key Findings**: The analysis reveals significant disparities in labor market participation between different demographic groups, with notable differences between urban and rural areas.

### 2. Educational Attainment and Employment Insurance
- **Objective**: Examine the relationship between educational attainment and the likelihood of being insured through employment, with a focus on gender differences.
- **Methods**: Logistic regression, weighted calculations to determine the proportion of insured individuals with higher education, and bar charts for visualization.
- **Key Findings**: The study highlights gender disparities in educational attainment among insured employees, with men generally having higher insurance coverage.

### 3. Sectoral Employment Types in Agriculture, Industry, and Services
- **Objective**: Investigate the distribution of employment types (self-employed vs. wage earners) across the agriculture, industry, and services sectors.
- **Methods**: Sectoral analysis with categorical data, visualization using bar charts to depict employment distributions across sectors.
- **Key Findings**: The analysis shows that agriculture is dominated by self-employment, while industry and services sectors have a higher proportion of wage earners.

### 4. Housing Conditions and Expenditures
- **Objective**: Assess housing conditions (ownership, renting, mortgaging) and analyze household expenditures on rent across different regions and demographics.
- **Methods**: Descriptive analysis, inflation-adjusted expenditure calculations, and visualization of housing trends.
- **Key Findings**: The majority of Iranian households own their homes, with rural areas showing higher ownership rates compared to urban areas. Rent expenditures have increased over time, particularly in urban areas.

### 5. Inequality and Consumption Patterns
- **Objective**: Measure economic inequality in Iran by analyzing the expenditure ratios between the highest and lowest deciles, and assess the impact of subsidy programs.
- **Methods**: Decile-based analysis, calculation of expenditure ratios, and trend analysis over two decades.
- **Key Findings**: The analysis indicates that subsidy programs initially reduced inequality, but the effects have diminished over time, with inequality gradually increasing in recent years.

## How to Use

1. **Running the Code**:
   - The `.do` files can be opened and executed in Stata to replicate the analyses. Each script is organized by the specific topic it addresses, allowing for modular analysis.

2. **Viewing the Reports**:
   - The `Report.pdf` files provide comprehensive documentation of the research, including the theoretical background, empirical methods, and detailed discussion of results for each project.


