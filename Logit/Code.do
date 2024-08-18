**************************************
*Fatemeh Abbasian-Abyaneh
*400100338
*Project 4, Microeconometrics 
**************************************
clear 
set more off
cd "C:\Users\fatem\Downloads\Stata\Project4"
set scheme gg_ptol
// Import data
import excel "SumU100.xls", firstrow

// Rename variables for clarity
rename C01 household_size
rename C04 household_employees
rename C05 household_income
rename A01 gender
rename A02 age
rename A05 education_level
rename B04 housing_area
rename A07 marital_status
rename C11New income_decile
rename C14 provincial_income_decile
rename A10New job_type
rename Daramad16 monthly_subsidy

// Label variables
label variable household_employees "Number of employees in household"
label variable household_income "Number of family members with income"
label variable gender "Gender of household head"
label variable age "Age of household head"
label variable education_level "Education level of household head"
label variable housing_area "Housing area in square meters"
label variable marital_status "Marital status of household head"
label variable income_decile "Household income decile"
label variable provincial_income_decile "Provincial income decile"
label variable job_type "Job type of household head"
label variable monthly_subsidy "Monthly subsidy received"

// Convert string variables to numeric
destring housing_area B01, replace

// Create ownership variable
gen home_owner = 0 
replace home_owner = 1 if (B01 == 1 | B01 == 2)

// Create gender dummy variable
gen is_female_head = 0 
replace is_female_head = 1 if gender == 2

// Create marital status dummy variable
gen is_married_head = 0
replace is_married_head = 1 if marital_status == 1

// Create education level categorical variable
gen education = 0 if A03 == 1
replace education = 1 if education_level == 1
replace education = 2 if education_level == 2 | education_level == 3 | education_level == 4
replace education = 3 if education_level == 5 | education_level == 6 | education_level == 7 
replace education = 4 if education_level == 8

// Create education status dummy variable
gen is_educated = 0
replace is_educated = 1 if A04 == 1

// Create employment status categorical variable
gen employment_status = 0 if A06 == 2
replace employment_status = 1 if A06 == 1
replace employment_status = 2 if A06 == 3

// Label employment status
label define employment_status 0 "unemployed" 1 "employed" 2 "unemployed with income" 
label values employment_status employment_status

// Convert subsidy and income to appropriate scales (billion toman)
gen income_in_billion = Daramad / 120000000
replace monthly_subsidy = monthly_subsidy / 12000000

// Convert car ownership to numeric
destring B07, replace
gen has_car = 0
replace has_car = 1 if B07 == 1

// Extract province and city codes from address
gen province_code = substr(ADDRESS, 2, 2)
gen city_code = substr(ADDRESS, 4, 2)

// Create dummy variables for Tehran and other metropolises
gen is_tehran = 0
replace is_tehran = 1 if (province_code == "23" & city_code == "01")

gen is_metropolis = 0
replace is_metropolis = 1 if (province_code == "09" | province_code == "10" | province_code == "30" | province_code == "06" | province_code == "07" | province_code == "25" | province_code == "03") & (city_code == "01")

// Create age cohorts
gen age_cohort = 0
replace age_cohort = 1 if age < 25
replace age_cohort = 2 if age >= 25 & age < 35
replace age_cohort = 3 if age >= 35 & age < 45
replace age_cohort = 4 if age >= 45 & age < 55
replace age_cohort = 5 if age >= 55 & age < 65
replace age_cohort = 6 if age >= 65 & age < 75
replace age_cohort = 7 if age >= 75

// Label age cohorts
label define age_cohort 1 "Head age < 25" 2 "25-35" 3 "35-45" 4 "45-55" 5 "55-65" 6 "65-75" 7 "Head age > 75"
label values age_cohort age_cohort

// Calculate household dependency ratio
gen dependency_ratio = household_employees / household_size

// Create job type categorical variable
gen job_status = job_type if (job_type == 1 | job_type == 2 | job_type == 3 | job_type == 4 | job_type == 5 | job_type == 6)
replace job_status = 0 if (A06 == 2)
replace job_status = 7 if (A06 == 3)

// Label job status
label define job_status 0 "unemployed" 1 "employer" 2 "self-employed" 3 "public sector" 4 "cooperative" 5 "private sector" 6 "unpaid family worker" 7 "unemployed with income"
label values job_status job_status

// Logistic regression models
logit home_owner household_size is_female_head is_married_head housing_area dependency_ratio education is_tehran has_car income_in_billion is_metropolis age monthly_subsidy, baselevels
estimates store logit1

logit home_owner household_size is_female_head is_married_head housing_area dependency_ratio education is_tehran has_car provincial_income_decile is_metropolis age monthly_subsidy, baselevels
estimates store logit2

logit home_owner household_size is_female_head is_married_head housing_area dependency_ratio education is_tehran has_car provincial_income_decile is_metropolis age monthly_subsidy i.employment_status, baselevels
estimates store logit3

logit home_owner household_size is_female_head is_married_head housing_area dependency_ratio education is_tehran has_car provincial_income_decile is_metropolis age monthly_subsidy i.job_status, baselevels
estimates store logit4

// Export logistic regression results to LaTeX
estout logit1 logit2 logit3 logit4 using logit_results.tex, replace style(tex) title("Logistic Regression Models") ///
    varlabels(_cons "Constant") ///
// Marginal effects for the final logistic model
margins, dydx(*) post
estimates store margins_logit
estout margins_logit using logit_margins.tex, replace style(tex) title("Marginal Effects for Logistic Model")

// Probit model
probit home_owner household_size is_female_head is_married_head housing_area dependency_ratio education is_tehran has_car provincial_income_decile is_metropolis age monthly_subsidy i.job_status, baselevels
estimates store probit1

// Marginal effects for the probit model
margins, dydx(*) post
estimates store margins_probit

// Export probit results to LaTeX
estout probit1 using probit_results.tex, replace style(tex) title("Probit Model") ///
    varlabels(_cons "Constant")

// Export probit marginal effects to LaTeX
estout margins_probit using probit_margins.tex, replace style(tex) title("Marginal Effects for Probit Model")


*Visulization

* Histogram of Household Size
histogram household_size, width(1) frequency ///
    title("Distribution of Household Size") xtitle("Household Size")
graph export "2.png", replace	
	
	
* Histogram for Homeowners' Income Distribution
histogram household_income if home_owner == 1, color(blue) ///
    title("Distribution of Homeowners Memebers with Income For Home-owners", size(3)) ///
    xtitle("Household Member with Income") ytitle("Frequency")
graph export "3.png", replace	
	

* Histogram for Non-Homeowners' Income Distribution
histogram household_income if home_owner == 0, color(red) ///
    title("Distribution of Homeowners Memebers with Income For Non-Home-owners", size(3)) ///
    xtitle("Household Member with Income") ytitle("Frequency")
graph export "4.png", replace

* Histogram for Education Levels of Homeowners
histogram education if home_owner == 1, discrete freq color(blue) ///
    title("Education Levels of Homeowners") ///
    xtitle("Education Level") ytitle("Frequency") ///
    xlabel(0 "Illiterate" 1 "Primary" 2 "Diploma" 3 "College Degree" 4 "Graduate Degree")
graph export "5.png", replace	
	
 *Histogram for Education Levels of Non-Homeowners
histogram education if home_owner == 0, discrete freq color(red) ///
    title("Education Levels of Non-Homeowners") ///
    xtitle("Education Level") ytitle("Frequency") ///
    xlabel(0 "Illiterate" 1 "Primary" 2 "Diploma" 3 "College Degree" 4 "Graduate Degree")	
graph export "6.png", replace	

graph bar (mean) home_owner, over(age_cohort) ascategory ytitle("Homeownership Rate") ///
    title("Homeownership Rates by Age Group") 
	xtitle("Age Cohort")
graph export "7.png", replace

histogram household_size, width(1) frequency ///
    title("Distribution of Household Size") ///
	xtitle("Household Size")
graph export "8.png", replace


*Histogram for Income in Billions of Homeowners
histogram income_in_billion if home_owner == 1, color(blue) ///
    title("Income Distribution in Billions of Homeowners") ///
    xtitle("Household Income (Billion Rial Monthly)") ytitle("Frequency")
graph export "9.png", replace
* Histogram for Income in Billions of Non-Homeowners
histogram income_in_billion if home_owner == 0, color(red) ///
    title("Income Distribution in Billions of Non-Homeowners") ///
    xtitle("Household Income (Billion Rial Monthly)") ytitle("Frequency")
graph export "10.png", replace






