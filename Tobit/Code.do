
**************************************
* Fatemeh Abbasian-Abyaneh
* 400100338
* Project 5, Microeconometrics 
**************************************
clear 
set more off
cd "C:\Users\fatem\Downloads\Stata\P5-400100338"
set scheme gg_ptol

/*------------------------------------------------------------------------------
   Step 1 : Merge Tables , Keep and Rename Necessary Variables         
------------------------------------------------------------------------------*/

// Load U1400Data table and keep necessary variables
use "Data_U_1401.dta", clear
keep address weight
save "U1400.dta", replace

// Load U1400P4S01 table and keep necessary variables
use "P4S01_U_1401.dta", clear
keep address dycol01 dycol11 
rename dycol11 wage
save "U1400P4S01.dta", replace

// Merge the two datasets using the Address variable
use "U1400.dta", clear
merge m:m address using "U1400P4S01.dta", keep(match)
drop _merge
save "P4S01DataCombined.dta", replace

// Load U1400P1 table and keep necessary variables
use "P1_U_1401.dta", clear
keep address dycol01 dycol04 dycol05 dycol06 dycol08 dycol10
save "U1400P1.dta", replace

// Merge with the previously merged dataset
use "P4S01DataCombined.dta", clear
merge m:m address dycol01 using "U1400P1.dta", keep(match)
drop _merge

// Rename variables for clarity
rename dycol04 gender
rename dycol05 age
rename dycol06 literacy_status
rename dycol08 education_level
rename dycol10 marital_status

/*------------------------------------------------------------------------------
   Step 2 : Convert Variables to Appropriate Formats and Generate New Variables
------------------------------------------------------------------------------*/

// Convert string variables to numeric
destring wage age gender literacy_status education_level marital_status, replace

// Generate the natural logarithm of wage
gen ln_wage = ln(wage)

// Create a new education variable based on education_level
gen education_years = .
replace education_years = 5 if education_level == 1 // primary
replace education_years = 8 if education_level == 2 // Middle school
replace education_years = 11 if education_level == 3 // Some High School
replace education_years = 12 if education_level == 4 // Diploma
replace education_years = 14 if education_level == 5 // Associate Degree
replace education_years = 16 if education_level == 6 // Bachelor
replace education_years = 18 if education_level == 7 // Master
replace education_years = 23 if education_level == 8 // PhD
replace education_years = 0 if literacy_status == 2 // Illiterate

// Convert gender variable to numeric and adjust it (0 for Female, 1 for Male)
encode gender, generate(gender_num)
replace gender_num = 0 if gender_num == 2
drop gender
rename gender_num gender


// Generate experience and its square
gen experience = age - education_years - 6
gen experience_squared = experience^2

// Adjust marital status variable (0 for Unmarried, 1 for Married)
replace marital_status = 0 if marital_status != 1

/*------------------------------------------------------------------------------
   Step 4 : Descriptive Statistics and Visualization
------------------------------------------------------------------------------*/
// Label and summarize gender
label define gender_label 0 "Female" 1 "Male", replace
label values gender gender_label
egen gender_pop = sum(weight), by(gender)
graph pie, over(gender_pop) plabel(_all name) title("Gender Composition")
graph export "gender_composition.png", replace

// Label and summarize literacy status
label define literacy_label 1 "Literate" 2 "Illiterate", replace
label values literacy_status literacy_label
egen literacy_pop = sum(weight), by(literacy_status)
graph pie, over(literacy_pop) plabel(_all name) title("Literacy Composition")
graph export "literacy_composition.png", replace

// Label and summarize marital status
label define marital_label 0 "Unmarried" 1 "Married", replace
label values marital_status marital_label
egen marital_pop = sum(weight), by(marital_status)
graph pie, over(marital_pop) plabel(_all name) title("Marital Status Composition")
graph export "marital_status_composition.png", replace

// Histogram of education years
hist education_years, title("Histogram of Education Years")
graph export "education_years_histogram.png", replace


/*------------------------------------------------------------------------------
   Step 4-Continued : Export Summary Statistics Using estout
------------------------------------------------------------------------------*/
// Summarize main variables
estpost summarize wage age education_years experience

// Export summary statistics using estout
estout using "summary_statistics.doc", cells("mean sd min max") replace


/*------------------------------------------------------------------------------
   Step 5 : Tobit Regression
------------------------------------------------------------------------------*/

// Perform Tobit regression with lower limit at zero
tobit ln_wage education_years experience experience_squared marital_status gender, ll(0)

// Export results using estout
estout using "myfile_tobit.doc", replace

/*------------------------------------------------------------------------------
   Step 6 : Additional Plots for Diagnostics
------------------------------------------------------------------------------*/


// Predict fitted values from Tobit regression
predict double xb if e(sample), xb

// Generate residuals manually
gen double residuals = ln_wage - xb if e(sample)

// Histogram of ln_wage
hist ln_wage, title("Histogram of LnWage")
graph export "hist_ln_wage.png", replace

// Plot residuals vs. fitted values
scatter residuals xb, title("Residuals vs. Fitted Values")
graph export "residuals_vs_fitted.png", replace

// Q-Q plot of residuals to check normality
qnorm residuals, title("Q-Q Plot of Residuals")
graph export "qq_plot_residuals.png", replace

// Scatter plot of predicted vs. actual ln_wage
scatter xb ln_wage, title("Predicted vs. Actual LnWage")
graph export "predicted_vs_actual_ln_wage.png", replace

/*------------------------------------------------------------------------------
   Step 7 : Additional Visualization Plots
------------------------------------------------------------------------------*/

// Scatter plot of ln_wage vs. education_years
scatter ln_wage education_years, title("LnWage vs. Education Years") ///
    xlabel(0(2)24) ylabel(0(0.5)10)
graph export "ln_wage_vs_education_years.png", replace

// Box plot of ln_wage by gender
graph box ln_wage, over(gender) title("Box Plot of LnWage by Gender")
graph export "boxplot_ln_wage_by_gender.png", replace

// Box plot of ln_wage by marital status
graph box ln_wage, over(marital_status) title("Box Plot of LnWage by Marital Status")
graph export "boxplot_ln_wage_by_marital_status.png", replace

// Scatter plot of ln_wage vs. experience
scatter ln_wage experience, title("LnWage vs. Experience") ///
    xlabel(0(5)50) ylabel(0(0.5)10)
graph export "ln_wage_vs_experience.png", replace

// Scatter plot of ln_wage vs. experience_squared
scatter ln_wage experience_squared, title("LnWage vs. Experience Squared") ///
    xlabel(0(25)2500) ylabel(0(0.5)10)
graph export "ln_wage_vs_experience_squared.png", replace

// Margins plot after Tobit regression
margins, at(education_years=(0(1)24))
marginsplot, title("Marginal Effect of Education Years on LnWage")
graph export "marginal_effect_education_years.png", replace

margins, at(experience=(0(1)50))
marginsplot, title("Marginal Effect of Experience on LnWage")
graph export "marginal_effect_experience.png", replace







