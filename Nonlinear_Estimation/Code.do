****Fatemeh Abbasian Abyaneh
****Project 3 : Nonlinear Methods in Econometrics
****400100338


// Clear any existing data in memory and set the working directory
clear
cd "C:\Users\fatem\Downloads\Stata\Project3-nonlinear"
set more off

// Load and prepare rural household data
odbc list
odbc query "HEIS1400", dialog(complete)
odbc desc "R1400Data"
odbc load, table("R1400Data") clear
gen UR = 0
save R1400Data, replace

clear
odbc list
odbc query "HEIS1400", dialog(complete)
odbc desc "R1400P1"
odbc load, table("R1400P1")
save R1400P1, replace
merge n:1 Address using R1400Data, nogen
save R1400Combined, replace

// Load and prepare urban household data
clear
odbc list
odbc query "HEIS1400", dialog(complete)
odbc desc "U1400Data"
odbc load, table("U1400Data") clear
gen UR = 1
save U1400Data, replace

clear
odbc list
odbc query "HEIS1400", dialog(complete)
odbc desc "U1400P1"
odbc load, table("U1400P1")
save U1400P1, replace
merge n:1 Address using U1400Data, nogen
save U1400Combined, replace

// Append rural and urban datasets
clear
use R1400Combined
append using U1400Combined
save CombinedData1400, replace


destring DYCOL01-DYCOL10, replace force
rename DYCOL01 Row
rename DYCOL03 Relation
rename DYCOL04 Gender
rename DYCOL05 Age
rename DYCOL06 Education
rename DYCOL08 EducationLevel
rename DYCOL09 Activity
rename DYCOL10 MarriageStatus

label define GenderLabel 1 "male" 2 "female"
label values Gender GenderLabel

egen FamilyNumber = count(Address), by(Address)


label define ur 1 "Urban" 0 "Rural"
label values UR ur

label define act 1 "Employed" 2 "Unemployed" 3 "Has Income" 4 "Student" 5 "Housekeeper" 6 "Others"
label values Activity act

gen PartnerActivity = .
replace PartnerActivity = 1 if Activity == 1 & Relation == 2
replace PartnerActivity = 2 if Activity == 2 & Relation == 2
replace PartnerActivity = 3 if Activity == 3 & Relation == 2
replace PartnerActivity = 4 if Activity == 4 & Relation == 2
replace PartnerActivity = 5 if Activity == 5 & Relation == 2
replace PartnerActivity = 6 if Activity == 6 & Relation == 2

bysort Address: replace PartnerActivity = PartnerActivity[_n-1] if missing(PartnerActivity)


egen ChildNumber = count(Address) if Relation == 3, by(Address)
bysort Address: replace ChildNumber = ChildNumber[_n-1] if missing(ChildNumber)
replace ChildNumber = 0 if ChildNumber == .

gen Province = substr(Address, 2, 2)
destring Province, replace force

label define ostan 0 "Markazi" 1 "Gilan" 2 "Mazandaran, Golestan" 3 "Azerbaijan(East)" 4 "Azerbaijan(West)" 5 "Kermanshah" 6 "Khuzestan" 7 "Fars" 8 "Kerman" 9 "Khorasan Razavi" 10 "Isfahan" 11 "Sistan and Baluchestan" 12 "Kurdistan" 13 "Hamadan" 14 "Chahar Mahaal and Bakhtiari" 15 "Lorestan" 16 "Ilam" 17 "Kohgiluyeh and Boyer-Ahmad" 18 "Bushehr" 19 "Zanjan" 20 "Semnan" 21 "Yazd" 22 "Hormozgan" 23 "Tehran" 24 "Ardabil" 25 "Qom" 26 "Qazvin" 27 "Golestan" 28 "Khorasan north" 29 "Khorasan south" 30 "Alborz"
label values Province ostan

gen years_of_edu = .
replace years_of_edu = 0 if Education == 2
replace years_of_edu = 5 if EducationLevel == 1
replace years_of_edu = 8 if EducationLevel == 2
replace years_of_edu = 11 if EducationLevel == 3
replace years_of_edu = 12 if EducationLevel == 4
replace years_of_edu = 14 if EducationLevel == 5
replace years_of_edu = 16 if EducationLevel == 6
replace years_of_edu = 18 if EducationLevel == 7
replace years_of_edu = 20 if EducationLevel == 8

gen PartnerEdu = years_of_edu if Relation == 2
bysort Address: replace PartnerEdu = PartnerEdu[_n-1] if missing(PartnerEdu)

gen SupervisorEdu = years_of_edu if Relation == 1
bysort Address: replace SupervisorEdu = SupervisorEdu[_n-1] if missing(SupervisorEdu)

egen EmpChild = count(Address) if Relation == 3 & Activity == 1, by(Address)
bysort Address: replace EmpChild = EmpChild[_n-1] if missing(EmpChild)
replace EmpChild = 0 if EmpChild == .

gen SupervisorAge = Age if Relation == 1
bysort Address: replace SupervisorAge = SupervisorAge[_n-1] if missing(SupervisorAge)

gen HusbandAge = Age if Relation == 2
bysort Address: replace HusbandAge = HusbandAge[_n-1] if missing(HusbandAge)

gen GrandParents = 1 if Relation == 6
bysort Address: replace GrandParents = GrandParents[_n-1] if missing(GrandParents)
replace GrandParents = 0 if GrandParents == .

gen SupervisorGender = Gender if Relation == 1
bysort Address: replace SupervisorGender = SupervisorGender[_n-1] if missing(SupervisorGender)

replace EducationLevel = 0 if EducationLevel == .
label define Sath_Savad 1 "primary" 2 "Middle-School" 3 "High School" 4 "Diploma" 5 "Post-Secondary" 6 "Bachelor" 7 "Maater" 8 "PhD" 0 "Illiterate" 9 "Others"
label values EducationLevel Sath_Savad

gen SupervisorEducationLevel = EducationLevel if Relation == 1
bysort Address: replace SupervisorEducationLevel = SupervisorEducationLevel[_n-1] if missing(SupervisorEducationLevel)

gen PartnerEducationLevel = EducationLevel if Relation == 2
bysort Address: replace PartnerEducationLevel = PartnerEducationLevel[_n-1] if missing(PartnerEducationLevel)

keep if Relation == 1
save "Data1400CleandedFinal", replace


// Load and prepare the income data for rural households
import excel "C:\Users\fatem\Downloads\Stata\Project3-nonlinear\SumR100.xlsx", firstrow clear
keep ADDRESS NHazineh Daramad
rename ADDRESS Address
destring NHazineh Daramad, replace force
gen UR = 0
duplicates drop Address, force
save SumR100, replace

// Load and prepare the income data for urban households
import excel "C:\Users\fatem\Downloads\Stata\Project3-nonlinear\SumU100.xlsx", firstrow clear
keep ADDRESS NHazineh Daramad
rename ADDRESS Address
destring NHazineh Daramad, replace force
gen UR = 1
duplicates drop Address, force
save SumU100, replace

// Append the income datasets
use SumR100, clear
append using SumU100, force
save Sum100Final, replace

// Merge the cleaned dataset with the income data
use "Data1400CleandedFinal", clear
merge n:n Address using Sum100Final, nogen
* CPI does not matter in this study, I assume it 1 for simplicity
gen CPI2 =  437.042
gen income = Daramad / CPI2
save Final1400WithIncome, replace




// Data preparation for visualization 



// Define labels for PartnerActivity
*label define act 1 "Employed" 2 "Unemployed" 3 "Haveincome" 4 "Student" 5 "Housekeeper" 6 "Others"
label values PartnerActivity act
*use "https://github.com/asjadnaqvi/Stata-schemes/blob/main/scheme_test.dta?raw=true", clear
set scheme gg_ptol


// Create visualizations
// Create a variable for family size categories
gen family_size = .
replace family_size = 1 if ChildNumber == 1
replace family_size = 2 if ChildNumber == 2
replace family_size = 3 if ChildNumber == 3
replace family_size = 4 if ChildNumber == 4
replace family_size = 5 if ChildNumber == 5
replace family_size = 6 if ChildNumber >= 6

// Pie chart of family size categories
graph pie, over(family_size) ///
    title("Family Size Categories") ///
    subtitle("Data Source: HEIS 1400") ///
    plabel(_all percent,size(1)) ///
    graphregion(color(white)) ///
    bgcolor(white)
graph export "family_size_pie_chart.png", replace



// Mean number of children by partner activity and urban/rural status
graph bar (mean) ChildNumber, over(PartnerActivity, gap(5)) by(UR, cols(1)) ///
    title("Mean Number of Children by Partner Activity and Urban/Rural Status", size(2)) ///
    ytitle("Mean Number of Children") ///
    blabel(bar, format(%9.2f)) ///
    legend(order(1 "Rural" 2 "Urban"))
    xlabel(1 "Employed" 2 "Unemployed" 3 "Has Income" 4 "Student" 5 "Housekeeper" 6 "Others")

graph export "mean_children_by_activity_vertical.png", replace




// Scatter plot for rural households
twoway (scatter ChildNumber income if UR == 0, ///
    mcolor(blue) msize(medium) mlabsize(small) mlabposition(0) ///
    title("Number of Children vs. Real Income (Rural)")), ///
    ytitle("Number of Children") xtitle("Real Income") ///
    legend(off) ///
    graphregion(color(white)) ///
    plotregion(color(white)) ///
    bgcolor(white)
graph export "children_vs_income_rural.png", replace

// Scatter plot for urban households
twoway (scatter ChildNumber income if UR == 1, ///
    mcolor(red) msize(medium) mlabsize(small) mlabposition(0) ///
    title("Number of Children vs. Real Income (Urban)")), ///
    ytitle("Number of Children") xtitle("Real Income(Rials,year 95)") ///
    legend(off) ///
    graphregion(color(white)) ///
    plotregion(color(white)) ///
    bgcolor(white)
graph export "children_vs_income_urban.png", replace


// Define labels for supervisor education
label define edu 1 "Primary" 2 "Middle-School" 3 "High School" 4 "Diploma" 5 "Post-Secondary" 6 "Bachelor" 7 "Master" 8 "PhD" 0 "Illiterate" 9 "Others"
label values SupervisorEducationLevel edu


// Box plot of education level of supervisor by urban/rural status
graph box SupervisorEducationLevel, over(UR, gap(5)) ///
    title("Education Level of Supervisor by Urban/Rural Status", size(2)) ///
    subtitle("Data Source: HEIS 1400") ///
    ytitle("Education Level") ///
    graphregion(color(white)) ///
    plotregion(color(white)) ///
    legend(off) ///
    bgcolor(white)
graph export "education_level_boxplot.png", replace





// Histogram of age distribution by urban/rural status with density plots
twoway (histogram SupervisorAge if UR == 0, width(5) color(blue) ///
        lcolor(blue) lwidth(medium) percent) ///
       (kdensity SupervisorAge if UR == 0, lcolor(blue) lwidth(medium)) ///
       (histogram SupervisorAge if UR == 1, width(5) color(red) ///
        lcolor(red) lwidth(medium) percent) ///
       (kdensity SupervisorAge if UR == 1, lcolor(red) lwidth(medium)), ///
        title("Age Distribution of Supervisors by Urban/Rural Status") ///
        subtitle("With Density Plots") ///
        ytitle("Percent") ///
        xtitle("Age") ///
        legend(order(1 "Rural Histogram" 2 "Rural Density" 3 "Urban Histogram" 4 "Urban Density") ///
               col(1) size(small) region(lcolor(black) lwidth(medium)) position(6)) ///
        graphregion(color(white)) ///
        plotregion(color(white)) ///
        yline(0, lcolor(black) lwidth(medium)) ///
        ylabel(, labcolor(black)) ///
        xlabel(, labcolor(black)) ///
        bgcolor(white)
graph export "age_distribution_histogram.png", replace

// Generate age groups
gen age_group = floor(Age/10)*10

// Calculate mean number of children by age group and urban/rural status
collapse (mean) ChildNumber, by(age_group UR)

// Line graph of mean number of children by age group and urban/rural status
twoway (line ChildNumber age_group if UR == 0, lcolor(blue) lwidth(medium)) ///
       (line ChildNumber age_group if UR == 1, lcolor(red) lwidth(medium)), ///
       title("Mean Number of Children by Age Group and Urban/Rural Status", size(3)) ///
       ytitle("Mean Number of Children") xtitle("Age Group") ///
       legend(order(1 "Rural" 2 "Urban") position(6) size(small)) ///
       graphregion(color(white)) ///
       plotregion(color(white)) ///
       bgcolor(white)
graph export "mean_children_by_age_group.png", replace



// Results for estimation

// posson regression
* Load the cleaned dataset
use "Final1400WithIncome", clear

* Estimate the Poisson regression model
poisson ChildNumber HusbandAge SupervisorEducationLevel PartnerEducationLevel income PartnerActivity, vce(robust)

* Export results to a .tex file for LaTeX
esttab using "poisson_results.tex", replace ///
    booktabs label se ar2 title("Poisson Regression Results") ///
    b(%9.3f) se(%9.3f) legend

	

//multinomial logit model	
// Load the dataset
use "Final1400WithIncome", clear
// Generate the multinomial dependent variable
gen ChildNumber_cat = .
replace ChildNumber_cat = 1 if ChildNumber == 0
replace ChildNumber_cat = 2 if ChildNumber == 1
replace ChildNumber_cat = 3 if ChildNumber == 2
replace ChildNumber_cat = 4 if ChildNumber == 3
replace ChildNumber_cat = 5 if ChildNumber >= 4

// Estimate the multinomial logit model
mlogit ChildNumber_cat Age SupervisorEducationLevel PartnerEducationLevel income PartnerActivity

// Store the results
eststo: mlogit ChildNumber_cat Age SupervisorEducationLevel PartnerEducationLevel income PartnerActivity

// Export the results to LaTeX
esttab using "multinomial_logit_results.tex", ///
    title("Multinomial Logit Regression Results") ///
    cells(b se p) ///
    compress ///
    style(tex) ///
    label

