


# Graduate Applied Econometrics

## Overview

This repository contains various projects and exercises completed as part of the Graduate Applied Econometrics course at Sharif University of Technology. The course emphasizes the application of advanced econometric techniques to real-world data, particularly focusing on national datasets such as the Household Income and Expenditure Survey (HEIS) and the Labor Force Survey (LFS). These datasets are invaluable for empirical analysis in the context of many countries, including Iran, offering deep insights into socio-economic dynamics.

## Course Outline

The Graduate Applied Econometrics course is designed to provide students with an in-depth understanding of econometric methods, drawing heavily on Jeffrey Wooldridge's *"Econometric Analysis of Cross Section and Panel Data."* The course covers a broad range of topics, with a particular emphasis on their theoretical foundations and practical applications.

### Linear Regression and Extensions

This section delves into both the fundamental and advanced aspects of linear regression analysis, a cornerstone of econometric modeling. The course covers Ordinary Least Squares (OLS) estimation in detail, exploring its properties under the Gauss-Markov assumptions. Extensions include dealing with violations of these assumptions, such as heteroskedasticity and autocorrelation, by introducing robust standard errors. Diagnostic tests, such as the Breusch-Pagan test for heteroskedasticity, the Durbin-Watson test for autocorrelation, and the Ramsey RESET test for model specification errors, are thoroughly discussed. The course also covers techniques for model selection, multicollinearity diagnostics, and methods for addressing endogeneity, such as Instrumental Variables (IV) estimation.

### Logit and Probit Models

This topic covers the estimation and interpretation of binary outcome models, which are essential when the dependent variable is dichotomous (e.g., yes/no, success/failure). The course includes an in-depth exploration of the maximum likelihood estimation (MLE) techniques used for Logit and Probit models, with a focus on the assumptions and limitations of each model. Advanced topics include the interpretation of marginal effects, goodness-of-fit measures like the McFadden R-squared, and handling issues such as rare events and separation. The course also discusses extensions to multinomial and ordered outcome models, as well as robust standard errors in the context of MLE.

### Tobit Models

The Tobit model is introduced as a solution for situations where the dependent variable is censored, such as when values are only observed above or below certain thresholds. This topic covers the formulation of the Tobit model, its estimation via maximum likelihood, and the interpretation of coefficients. The course further explores the potential biases in OLS estimates when applied to censored data, and how the Tobit model addresses these issues. Extensions of the Tobit model, such as the two-part model and sample selection models (e.g., Heckman correction), are also discussed, providing a comprehensive understanding of how to handle censored and truncated data in empirical research.

### Panel Data Analysis

Panel data models allow economists to control for unobserved heterogeneity by exploiting the longitudinal nature of the data, where the same entities are observed across multiple time periods. The course covers both static and dynamic panel data models, beginning with fixed effects (FE) and random effects (RE) models, and discussing their underlying assumptions and appropriate uses. Advanced topics include the Hausman test for model selection between FE and RE, and methods to address dynamic panel bias, such as the Arellano-Bond estimator. The course also covers issues related to panel data, including autocorrelation and heteroskedasticity within panel data contexts, and the use of Generalized Method of Moments (GMM) estimators.

### Propensity Score Matching

Propensity Score Matching (PSM) is a non-experimental technique used to estimate causal effects in observational studies by accounting for confounding variables. The course covers the theoretical foundation of PSM, including the concept of the propensity score and its estimation via logit or probit models. Students learn how to implement matching techniques, such as nearest neighbor matching, radius matching, and kernel matching, and how to assess the quality of matches using balancing tests. The course also discusses the limitations of PSM, such as its reliance on the ignorability assumption, and how to combine PSM with other methods like difference-in-differences (DiD) to strengthen causal inference.

### Nonlinear Estimation

Nonlinear estimation techniques are essential when the relationship between the dependent and independent variables is not linear. This section covers methods for estimating nonlinear models, including nonlinear least squares (NLS) and maximum likelihood estimation (MLE) for nonlinear models. The course explores the derivation and implementation of these estimators, along with their asymptotic properties. Special attention is given to models with nonlinearities in parameters, such as exponential and logistic growth models, and to the use of nonlinear instruments in IV estimation. Students also learn about the challenges of convergence in nonlinear estimation and the use of algorithms like Newton-Raphson and Gauss-Newton methods.

## Significance of National Datasets

The course heavily relies on national datasets, such as HEIS and LFS, which are critical for understanding and analyzing economic and social issues at the national level.

### Household Income and Expenditure Survey (HEIS)

HEIS is a comprehensive dataset that captures detailed information on household income, expenditure, and consumption patterns across Iran. It is invaluable for analyzing living standards, poverty, income distribution, and consumer behavior. The dataset's granularity allows for in-depth socio-economic analysis across different regions and demographic groups, providing insights that are essential for policy formulation and economic planning.

### Labor Force Survey (LFS)

The Labor Force Survey (LFS) provides extensive data on employment, unemployment, labor market participation, and demographic characteristics of the labor force. It is an essential resource for analyzing labor market dynamics, including employment trends, sectoral shifts, and workforce demographics. The LFS data is crucial for understanding the factors that drive labor market outcomes and for assessing the impact of economic policies on employment.

These datasets are not only relevant to Iran but are also commonly used in other countries, making them suitable for comparative studies and international research.

## Repository Structure

- **Logit**: Contains projects related to the estimation and interpretation of logit models, including advanced topics such as multinomial and ordered logit models.
- **Nonlinear_Estimation**: Includes projects that focus on the estimation of models where the relationship between variables is nonlinear, including the use of nonlinear instruments.
- **Panel**: This directory contains projects related to panel data analysis, covering both static and dynamic models, as well as GMM estimators.
- **Propensity_Score_Matching**: Projects that use propensity score matching to estimate causal effects in observational studies, along with assessments of matching quality.
- **STATA**: General scripts and exercises in STATA related to various econometric techniques covered in the course.
- **Tobit**: Contains projects involving the estimation of censored regression models, addressing issues such as sample selection and truncation.


