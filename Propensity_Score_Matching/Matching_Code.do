/*******************************************************************************
Title: Project 6
Course: Microeconometrics
Author: Fatemeh Abbasian
StudentID: 400100338
********************************************************************************/
clear
set more off
cd "C:\Users\fatem\Downloads\Stata\P6-400100338"
set scheme gg_ptol
************************************************
* Address and Weight data *
************************************************
* Including weight and address for rural and urban households

* Processing rural data
use Data_R_1400, clear
gen UR = 0
save "R1400Data.dta", replace

* Processing urban data
use Data_U_1400, clear
gen UR = 1
save "U1400Data.dta", replace

* Keeping only the necessary variables and renaming them
keep Address weight UR
label variable weight "Weight"
label variable UR "Urban/Rural"
destring weight UR, replace force

* Combining rural and urban data
append using "R1400Data.dta"
save "CombinedDataWeight.dta", replace

************************************************
* Household Members Characteristics *
************************************************
* Processing rural data
use P1_R_1400, clear
gen UR = 0
save "R1400P1.dta", replace

* Processing urban data
use P1_U_1400, clear
gen UR = 1
save "U1400P1.dta", replace

* Combining rural and urban data
append using "R1400P1.dta"
save "CombinedP1.dta", replace

* Renaming variables
rename DYCOL03 Rel
rename DYCOL04 Gender
rename DYCOL05 Age
rename DYCOL07 does_study
rename DYCOL08 Education
rename DYCOL09 Work_Status

* Labeling variables
label variable Rel "Relation to Head of Family"
label variable Gender "Male or Female"
label variable Age "Age"
label variable Education "Education"
label variable does_study "Does Study"
label variable UR "Urban/Rural"
label variable Work_Status "Working Status"

* Keeping necessary variables and converting to numeric
keep Address Rel Gender Age Education does_study UR Work_Status
destring Rel Gender Age Education does_study UR Work_Status, replace force

* Merging with combined weight data
merge m:1 Address using "CombinedDataWeight.dta"
drop _merge

* Education level
gen education_years = .
replace education_years = 5 if Education == 1 // primary
replace education_years = 8 if Education == 2 // Middle school
replace education_years = 11 if Education == 3 // Some High School
replace education_years = 12 if Education == 4 // Diploma
replace education_years = 14 if Education == 5 // Associate Degree
replace education_years = 16 if Education == 6 // Bachelor
replace education_years = 18 if Education == 7 // Master
replace education_years = 23 if Education == 8 // PhD
replace education_years = 0 if Education == 9 // Illiterate

* Generating Province variable
gen prov = substr(Address, 2, 2)
label variable prov "Province"
destring prov, replace
label define Province 0 "Markazi" 1 "Gilan" 2 "Mazandaran" 3 "Azarbayjan-E-Sharghi" 4 "Azarbayjan-E-Gharbi" 5 "Kermanshah" 6 "Khouzestan" 7 "Fars" 8 "Kerman" 9 "Khorasan-E-Razavi" 10 "Isfahan" 11 "Sistan-va-Balouchestan" 12 "Kordestan" 13 "Hamedan" 14 "Bakhtyari" 15 "Lorestan" 16 "Ilam" 17 "Kohkilouye" 18 "Boushehr" 19 "Zanjan" 20 "Semnan" 21 "Yazd" 22 "Hormozgan" 23 "Tehran" 24 "Ardabil" 25 "Qom" 26 "Qazvin" 27 "Golestan" 28 "Khorasan-E-Shomali" 29 "Khorasan-E-Jonoubi" 30 "Alborz"
label values prov Province

* Creating variables to capture household head and spouse
gen is_head = (Rel == 1)
gen is_spouse = (Rel == 2)
gen is_mother_working = 0 
replace is_mother_working = 1 if Gender == 2 & Work_Status == 1

* Creating a variable to capture the family size
bysort Address: gen family_size = _N

* Creating temporary variables for collapsing
gen head_education_years_temp = education_years if is_head
gen spouse_education_years_temp = education_years if is_spouse
gen head_age_temp = Age if is_head
gen spouse_age_temp = Age if is_spouse
gen head_gender_temp = Gender if is_head
gen spouse_gender_temp = Gender if is_spouse

* Aggregating data to household level
collapse (max) UR prov family_size is_mother_working ///
    (mean) head_education_years = head_education_years_temp spouse_education_years = spouse_education_years_temp ///
    (max) head_age = head_age_temp spouse_age = spouse_age_temp ///
    (max) head_gender = head_gender_temp spouse_gender = spouse_gender_temp, by(Address)

* Saving the final dataset
save "FinalCombinedData.dta", replace

*************************************************************
**educational expenditure
*************************************************************

*rural
use P3S13_R_1400, clear 
gen UR = 0
save "R1400P3S13", replace
 
*urban
use P3S13_U_1400, clear 
gen UR = 1
save "U1400P3S13", replace
append using "R1400P3S13"
save "CombinedP3S13", replace
 

rename DYCOL01 GoodCode
rename DYCOL05 Education_Expenditure
gen Code = substr(GoodCode,1,3)
gen Education = 1 if Code=="095" | Code=="096" | Code=="101" | Code=="102"| Code=="103"| Code=="104"| Code=="105"
drop if Education!=1
destring Education_Expenditure, replace force

collapse (sum)  Education_Expenditure, by(Address)
merge 1:1 Address using "FinalCombinedData.dta"
drop _merge

save "CombinedP3S13Education.dta", replace  
 
*************************************************************
****income from subsidy
*************************************************************
*rural
use P4S4_R_1400, clear 
gen UR = 0
save "R1400P4S4", replace
 
*urban
use P4S4_U_1400, clear 
gen UR = 1
save "U1400P4S4", replace
append using "R1400P4S4"
save "CombinedP4S4", replace 
 

rename Dycol05 subsidy_income
destring subsidy_income, replace
collapse (sum) subsidy_income, by(Address)

merge 1:1 Address using "CombinedP3S13Education.dta"
drop _merge

save "CombinedP4S4Subsidy.dta", replace
************************************************************
*Household Expenditure 
************************************************************
import excel "SumU100.xlsx", firstrow clear
save "SumU100.dta", replace
************************************************************
import excel "SumR100.xlsx", firstrow clear
save "SumR100.dta",replace
************************************************************
append using "SumU100.dta"
save "CombinedSummery.dta", replace
rename ADDRESS Address
rename C01 Size
rename NHazineh Net_Expenditure
rename VKhorak VKhorak
rename VGheirehKhorak VGheirehKhorak
gen Total_Expenditure=(VKhorak+VGheirehKhorak)/Size
lab var Size "Household Size"
lab var Net_Exp "Pure Cost"
lab var Total_Expenditure "Total Expenditures"
drop weight
save "FinalCombinedSummary.dta", replace
************************************************************
* Merging final datasets based on Address *
************************************************************
use "FinalCombinedSummary.dta", clear

merge 1:1 Address  using "CombinedP4S4Subsidy.dta", keep(match) nogenerate
save "FinalMergedDataset.dta", replace
************************************************************
*Conducting Matching Algorithm
************************************************************
* Load the final merged dataset
use "FinalMergedDataset.dta", clear

* Generate a binary variable for treatment
gen treatment = is_mother_working

* Describe and summarize the treatment and covariates
describe treatment Education_Expenditure family_size head_education_years spouse_education_years head_age spouse_age UR prov Total_Expenditure
summarize treatment Education_Expenditure family_size head_education_years spouse_education_years head_age spouse_age UR prov Total_Expenditure

* Estimate the propensity scores using logistic regression with interaction terms
logit treatment family_size head_education_years spouse_education_years head_age spouse_age UR Total_Expenditure subsidy_income prov ///
    c.family_size##c.head_education_years c.head_age##c.spouse_age i.UR#c.Total_Expenditure

* Predict the propensity scores
predict pscore, pr

* Perform nearest neighbor matching using psmatch2
ssc install psmatch2, replace  // Ensure psmatch2 is installed
psmatch2 treatment, pscore(pscore) outcome(Education_Expenditure) neighbor(1) caliper(0.05) logit

* Check balance after matching
pstest family_size head_education_years spouse_education_years head_age spouse_age UR Total_Expenditure subsidy_income prov, graph

* Summary statistics for the entire dataset
estpost summarize treatment Education_Expenditure family_size head_education_years spouse_education_years head_age spouse_age UR Total_Expenditure subsidy_income prov
esttab using summary_stats_whole.tex, cells("mean sd min max") label title("Summary Statistics for Whole Dataset") replace

* Summary statistics for treatment and control groups
estpost summarize family_size head_education_years spouse_education_years head_age spouse_age UR Total_Expenditure subsidy_income prov if treatment == 1
esttab using summary_stats_treatment.tex, cells("mean sd min max") label title("Summary Statistics for Treatment Group") replace

estpost summarize family_size head_education_years spouse_education_years head_age spouse_age UR Total_Expenditure subsidy_income prov if treatment == 0
esttab using summary_stats_control.tex, cells("mean sd min max") label title("Summary Statistics for Control Group") replace

* Perform nearest neighbor matching using psmatch2
psmatch2 treatment, pscore(pscore) outcome(Education_Expenditure) neighbor(1) caliper(0.05) logit

* Save matching results
esttab using matching_results.tex, cells("b se t p") label title("Matching Results") replace

* Estimate the Average Treatment Effect on the Treated (ATT) using teffects psmatch
teffects psmatch (Education_Expenditure) (treatment family_size head_education_years spouse_education_years head_age spouse_age UR Total_Expenditure subsidy_income prov), atet

* Save ATT results
esttab using att_results.tex, cells("b se t p") label title("Average Treatment Effect on the Treated (ATT)") replace

* Plot the distribution of propensity scores
twoway (kdensity pscore if treatment==1, lcolor(blue) lpattern(solid) ) ///
       (kdensity pscore if treatment==0, lcolor(red) lpattern(dash) ), ///
       legend(label(1 "Treated") label(2 "Control")) ///
       title("Distribution of Propensity Scores") ///
       xtitle("Propensity Score") ytitle("Density")

* Save the plot
graph export propensity_score_distribution.png, replace


* Save the final matched dataset
save "FinalMatchedDataset.dta", replace

