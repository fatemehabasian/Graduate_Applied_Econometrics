
# Economic Analysis of Urban Workers’ Wage in Iran

## Overview

This repository contains the code and report for an econometrics project that investigates the determinants of wages among urban workers in Iran. The study uses a Tobit regression model to analyze the impact of education, experience, gender, and marital status on wages. The Tobit model is particularly suited for this analysis due to the censored nature of wage data, which often has a lower bound at zero.

## Project Structure

- **`Code.do`**: The Stata script that implements the Tobit regression analysis. The code processes the data, estimates the model, and generates diagnostic plots.
- **`Report.pdf`**: The detailed report documenting the research findings, methodology, and analysis. The report includes a literature review, data description, Tobit model specification, results, and policy implications.

## Project Description

### Research Question

The project explores the following key question:
- What are the key determinants of wages among urban workers in Iran, and how do factors such as education, experience, gender, and marital status influence earnings?

### Methodology

- **Data Source**: The study utilizes data from the Household Expenditure and Income Survey for urban households in Iran (2021). The sample includes 12,399 employed individuals.
- **Empirical Strategy**: A Tobit regression model is employed to estimate the effects of various factors on wages. This model is chosen because wage data is often censored, meaning that some values are either not observed or are truncated at a certain level (e.g., zero).

### Key Findings

- **Education**: Each additional year of education is associated with a 6.75% increase in the natural logarithm of wages, highlighting the importance of educational attainment in enhancing earnings potential.
- **Experience**: The analysis finds that work experience positively influences wages, but with diminishing returns over time. This suggests that while experience is valuable, its incremental benefits decrease as individuals gain more years in the workforce.
- **Gender**: A significant gender wage gap is observed, with males earning approximately 30.76% more than females, indicating the presence of gender-based wage discrimination in the labor market.
- **Marital Status**: Being married is associated with a 25.42% higher wage compared to unmarried individuals, potentially due to greater stability and support systems.

## How to Use

1. **Running the Code**:
   - Open the `Code.do` file in Stata to replicate the analysis. The code includes data preparation, model estimation, and diagnostic checks.

2. **Viewing the Report**:
   - The `Report.pdf` provides a comprehensive explanation of the research, including the theoretical background, empirical methods, and detailed discussion of the results.


