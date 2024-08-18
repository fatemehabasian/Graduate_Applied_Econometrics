/*******************************************************************************
Title: HIES Project
Course: Microeconometrics
Author: Fatemeh Abbasian
StudentID: 400100338
********************************************************************************/



clear
set more off
cd "C:\Users\fatem\Downloads\Stata\HIES\Code"
****************************************************this code would call HEIS from odbc
*do "C:\Users\fatem\Downloads\Stata\HIES\Code\MDBToDTA.do" 
 
************************************************Adress and Weight data***********************************************************************
use Data_R_1398 ,clear
gen UR=0
gen Year=1398
save "R1398Data" , replace


use Data_R_1399 ,clear
gen UR=0
gen Year=1399
save "R1399Data" , replace

use Data_R_1400 ,clear
gen UR=0
gen Year=1400
save "R1400Data" , replace

use Data_R_1401 ,clear
gen UR=0
gen Year=1401
save "R1401Data" , replace
 

 
use Data_U_1398 ,clear
gen UR=1
gen Year=1398
save "U1398Data" , replace

use Data_U_1399 ,clear
gen UR=1
gen Year=1399
save "U1399Data" , replace

use Data_U_1400 ,clear
gen UR=1
gen Year=1400
save "U1400Data" , replace

use Data_U_1401 ,clear
gen UR=1
gen Year=1401
save "U1401Data" , replace
*************************************************Demographic data prepration***************************************************************


use P1_R_1398 ,clear
gen UR=0
gen Year=1398
save "R1398P1" , replace


use P1_R_1399 ,clear
gen UR=0
gen Year=1399
save "R1399P1" , replace


use P1_R_1400 ,clear
gen UR=0
gen Year=1400
save "R1400P1" , replace


use P1_R_1401 ,clear
gen UR=0
gen Year=1401
save "R1401P1" , replace



use P1_U_1398 ,clear
gen UR=1
gen Year=1398
save "U1398P1" , replace


use P1_U_1399 ,clear
gen UR=1
gen Year=1399
save "U1399P1" , replace


use P1_U_1400 ,clear
gen UR=1
gen Year=1400
save "U1400P1" , replace


use P1_U_1401 ,clear
gen UR=1
gen Year=1401
save "U1401P1" , replace
***************************************************Fruits section data prepration*******************************************************

use P3S01_R_1398 ,clear
gen Year=1398
save "R1398P3S01" , replace


use P3S01_R_1399 ,clear
gen Year=1399
save "R1399P3S01" , replace


use P3S01_R_1400 ,clear
gen Year=1400
save "R1400P3S01" , replace


use P3S01_R_1401 ,clear
gen Year=1401
save "R1401P3S01" , replace



use P3S01_U_1398 ,clear
gen Year=1398
save "U1398P3S01" , replace


use P3S01_U_1399 ,clear
gen Year=1399
save "U1399P3S01" , replace


use P3S01_U_1400 ,clear
gen Year=1400
save "U1400P3S01" , replace


use P3S01_U_1401 ,clear
gen Year=1401
save "U1401P3S01" , replace


****************************************************Clothing section data prepration ***********************************************
use P3S03_R_1398 ,clear
gen Year=1398
save "R1398P3S03" , replace


use P3S03_R_1399 ,clear
gen Year=1399
save "R1399P3S03" , replace


use P3S03_R_1400 ,clear
gen Year=1400
save "R1400P3S03" , replace


use P3S03_R_1401 ,clear
gen Year=1401
save "R1401P3S03" , replace



use P3S03_U_1398 ,clear
gen Year=1398
save "U1398P3S03" , replace


use P3S03_U_1399 ,clear
gen Year=1398
save "U1399P3S03" , replace


use P3S03_U_1400 ,clear
gen Year=1400
save "U1400P3S03" , replace


use P3S03_U_1401 ,clear
gen Year=1401
save "U1401P3S03" , replace

**************************************************Housing section data prepration********************************************
use P2_R_1398 ,clear
gen UR=0
gen Year=1398
save "R1398P2" , replace


use P2_R_1399 ,clear
gen UR=0
gen Year=1399
save "R1399P2" , replace


use P2_R_1400 ,clear
gen UR=0
gen Year=1400
save "R1400P2" , replace


use P2_R_1401 ,clear
gen UR=0
gen Year=1401
save "R1401P2" , replace



use P2_U_1398 ,clear
gen UR=1
gen Year=1398
save "U1398P2" , replace


use P2_U_1399 ,clear
gen UR=1
gen Year=1399
save "U1399P2" , replace


use P2_U_1400 ,clear
gen UR=1
gen Year=1400
save "U1400P2" , replace


use P2_U_1401 ,clear
gen UR=1
gen Year=1401
save "U1401P2" , replace

****************************************************************preparing P3S04 /rental data********************************************
use P3S04_R_1398 ,clear
gen UR=0
gen Year=1398
save "R1398P3S04" , replace


use P3S04_R_1399 ,clear
gen UR=0
gen Year=1399
save "R1399P3S04" , replace


use P3S04_R_1400 ,clear
gen UR=0
gen Year=1400
save "R1400P3S04" , replace


use P3S04_R_1401 ,clear
gen UR=0
gen Year=1401
save "R1401P3S04" , replace



use P3S04_U_1398 ,clear
gen UR=1
gen Year=1398
save "U1398P3S04" , replace


use P3S04_U_1399 ,clear
gen UR=1
gen Year=1399
save "U1399P3S04" , replace


use P3S04_U_1400 ,clear
gen UR=1
gen Year=1400
save "U1400P3S04" , replace


use P3S04_U_1401 ,clear
gen UR=1
gen Year=1401
save "U1401P3S04" , replace 
 
************************combining Data form for all years and areas*******************************household level data
use "R1398Data", clear
local datasets "R1399Data R1400Data R1401Data U1398Data U1399Data U1400Data U1401Data"
foreach file in `datasets' {
    append using `file', force
}
keep address weight UR Year
rename address Address
rename weight  W
label variable W "Weight"
label variable UR "Urban\Rural"
destring W UR Year , replace force
save "CombinedDataWeight.dta", replace

 
************************combining P1 form for all years and areas*******************************individaul level data

use "R1398P1", clear
local datasets "R1399P1 R1400P1 R1401P1 U1398P1 U1399P1 U1400P1 U1401P1"
foreach file in `datasets' {
    append using `file', force
}
rename address Address
rename dycol03 Rel
rename dycol04 Gender
rename dycol05 Age
rename dycol08 Edu
rename dycol09 Act_Status
rename dycol10 Mar_Status
label variable Rel "Relation to Head of family"
label variable Gender "Male or Female"
label variable Age "Age"
label variable Edu "Education"
label variable Act_Status "Activity Status"
label variable Mar_Status "Marital Status"
label variable UR "Urban\Rural"
keep Address Rel Gender Age Edu Act_Status Mar_Status UR Year 
destring Rel Gender Age Edu Act_Status Mar_Status UR Year , replace force
merge m:1 Address Year using "CombinedDataWeight.dta"
drop _merge
save "CombinedP1FamChar.dta", replace
**************************************one way to calulate family size for each individual
*use "CombinedP1FamChar.dta",clear
*egen FamilyID = group(Address Year), label
*bysort FamilyID: gen FamilySize = _N
*duplicates drop FamilyID, force
* "FamilySizeP1FamChar.dta", replace
****************************************another wat to calculate family size
use "CombinedP1FamChar.dta",clear
gen Family_Size = 1
collapse (sum) Family_Size, by(Address Year)
save "Family_Size.dta", replace
 
	
************************combining P2 form for all years and areas*******************************Household level 

use "R1398P2", clear
local datasets "R1399P2 R1400P2 R1401P2 U1398P2 U1399P2 U1400P2 U1401P2"
foreach file in `datasets' {
    append using `file', force
}
ren address Address
ren dycol01 Housing_Type
destring Housing_Type, replace force
keep Address Year UR Housing_Type
label variable Housing_Type "Housing type"
label variable UR "Urban\Rural"
merge 1:1 Address Year using "CombinedDataWeight.dta"
save "CombinedP2Housing.dta", replace
 
************************combining P3S01 form for all years and areas*******************************Houshold level

use "R1398P3S01", clear
local datasets "R1399P3S01 R1400P3S01 R1401P3S01 U1398P3S01 U1399P3S01 U1400P3S01 U1401P3S01"
foreach file in `datasets' {
    append using `file', force
}
rename address Address
rename dycol01 GoodCode
ren dycol06 FruitExpenditure
gen Code = substr(GoodCode,1,5)
gen Fruit = 1 if Code=="01161" | Code=="01162" | Code=="01163" | Code=="01164"
drop if Fruit!=1
destring FruitExpenditure, replace force
collapse (sum) FruitExpenditure, by(Address Year)
merge 1:1 Address Year using "CombinedDataWeight.dta"
drop _merge
save "CombinedP3S01Fruits.dta", replace 
 
************************combining P3S03 form for all years and area to calculate clothes expenditures*************Household level******

use "R1398P3S03", clear
local datasets "R1399P3S03 R1400P3S03 R1401P3S03 U1398P3S03 U1399P3S03 U1400P3S03 U1401P3S03"
foreach file in `datasets' {
    append using `file', force
}
rename address Address
rename dycol01 GoodCode
ren dycol03 ClothesExpenditure
gen Code = substr(GoodCode,1,3)
gen Clothes = 1 if Code=="031"
drop if Clothes!=1
destring ClothesExpenditure, replace force
collapse (sum) ClothesExpenditure, by(Address Year)
merge 1:1 Address Year using "CombinedDataWeight.dta"
drop _merge
save "CombinedP3S03Clothes.dta", replace 
**********************combining P3S04 form for all years and area to calculate housing expenditures*************Household level******
use "R1398P3S04", clear
local datasets "R1399P3S04 R1400P3S04 R1401P3S03 U1398P3S04 U1399P3S04 U1400P3S04 U1401P3S04"
foreach file in `datasets' {
    append using `file', force
}
rename address Address
rename dycol01 GoodCode
ren dycol04 RentExpenditure
gen Code = substr(GoodCode,1,3)
gen Rent = 1 if Code=="041" | Code=="042"
drop if Rent!=1
destring RentExpenditure , replace force
collapse (sum) RentExpenditure, by(Address Year)
merge 1:1 Address Year using "CombinedDataWeight.dta"
drop _merge
save "CombinedP3S04Housings.dta", replace 

 
************************************in Q1 we work on P1 form(family characteriscs)************************************************
***********************************extracting provinces***************************************************************************
 
use "CombinedP1FamChar.dta", clear
 
 
gen prov = substr(Address,2,2)
label variable prov "Province"
destring prov, replace
label define Province 0 "Markazi" 1 "Gilan" 2 "Mazandaran" 3 "Azarbayjan-E-Sharghi" 4 "Azarbayjan-E-Gharbi" 5 "Kermanshah" 6 "Khouzestan" 7 "Fars" 8 "Keramn" 9 "Khorasan-E-Razavi" 10 "Isfahan" 11 "Sistan-va-Balouchestan" 12 "Kordestan" 13 "Hamedan" 14 "Bakhtyari" 15 "Lorestan" 16 "Ilam" 17 "Kohkilouye" 18 "Boushehr" 19 "Zanjan" 20 "Semnan" 21 "Yazd" 22 "Hormozgan" 23 "Tehran" 24 "Ardabil" 25 "Qom" 26 "Qazvin" 27 "Golestan" 28 "Khorasan-E-Shomali" 29 "Khorasan-E-Jonoubi" 30 "Alborz" 
label values prov Province

*****************************************************************creating binary variable to determin individuals' gender
 
 

 
* Creating binary variables for gender, activity, and marital status
gen IsMale = (Gender == 1)
gen IsFemale = (Gender == 2)
drop if Age < 15
***************************Q1 is focused on female work partcipation so I filtered the data for female only
keep if IsFemale==1
gen IsEmployed = (Act_Status == 1)
gen IsUnemployed = (Act_Status == 2)
gen IsActive = (IsEmployed | IsUnemployed)
gen IsMarried = (Mar_Status == 1)
 
 
 
* Labeling education levels
label define Levels 1 "Primary" 2 "Middle School" 3 "High School" 4  "Post Secondary" 5 "Associate Degree" 6 "College" 7 "Graduate-Master" 8 "Graduate-PHD" 9 "Others"
label values Edu Levels
replace Edu = 9 if missing(Edu)

save "Q1.dta", replace 

 
 
**************************************************************************Q1-1 
use "Q1.dta", clear

* Calculating participation rates
 
bys Year: egen TotalWeight = total(W)
bys Year: egen ActiveWeight= total(W* (IsActive==1))
bys Year: gen ParticipationRate = (ActiveWeight / TotalWeight) * 100

* Calculating participation rates by urban and rural
bys UR Year: egen TotalWeight_UR = total(W)
bys UR Year: egen ActiveWeight_UR = total(W* (IsActive==1))
bys UR Year: gen ParticipationRate_UR = (ActiveWeight_UR / TotalWeight_UR) * 100

* Dropping intermediate variables to clean up the dataset
 
twoway (line ParticipationRate Year, lcolor(black) msymbol(o)) ///
       (line ParticipationRate_UR Year if UR == 0, lcolor(red) msymbol(o)) ///
       (line ParticipationRate_UR Year if UR == 1, lcolor(green) msymbol(o)), ///
       legend(label(1 "Total Country") label(2 "Rural") label(3 "Urban")) ///
       ylabel(10(1)14) xlabel(1398(1)1401, format(%4.0f)) ///
       title("Female Participation Rate Trends  1398-1401 by Area") ///
       note("Participation rate: Share of active individuals (employed or unemployed seeking work), weighted by W")

* Exporting the graph
graph export "1-1.png", replace

*****************************************************************Q1-2 the trend of female particpation rate across education leveles
* Use the dataset with individual characteristics
use "Q1.dta", clear

* Keep only married females
keep if IsMarried == 1 & IsFemale == 1

* Ensure variables are in the correct format
 
* Calculate the weighted participation for each education level by year
egen WeightEduYear = sum(W), by(Year Edu)
egen ActiveWeightEduYear = sum(W * IsActive), by(Year Edu)

* Calculate the participation rates by education level and year
gen ParticipationRateEduYear = ActiveWeightEduYear / WeightEduYear

* Collapse the data to have one observation per education level per year
collapse (mean) ParticipationRateEduYear, by(Year Edu)

* Prepare the data for graphing by reshaping
reshape wide ParticipationRateEduYear, i(Year) j(Edu)

* Graph the participation rates by education level across years
twoway (line ParticipationRateEduYear1 Year, color(red) lwidth(medium) title("Primary")) ///
       (line ParticipationRateEduYear2 Year, color(green) lwidth(medium) title("Middle School")) ///
       (line ParticipationRateEduYear3 Year, color(blue) lwidth(medium) title("High School")) ///
       (line ParticipationRateEduYear4 Year, color(orange) lwidth(medium) title("Post Secondary")) ///
       (line ParticipationRateEduYear5 Year, color(purple) lwidth(medium) title("Associate Degree")) ///
       (line ParticipationRateEduYear6 Year, color(magenta) lwidth(medium) title("College")) ///
       (line ParticipationRateEduYear7 Year, color(yellow) lwidth(medium) title("Graduate-Master")) ///
       (line ParticipationRateEduYear8 Year, color(cyan) lwidth(medium) title("Graduate-PHD")) ///
       (line ParticipationRateEduYear9 Year, color(black) lwidth(medium) title("Others")), ///
       legend(order(1 "Primary" 2 "Middle School" 3 "High School" 4 "Post Secondary" 5 "Associate Degree" 6 "College" 7 "Graduate-Master" 8 "Graduate-PHD" 9 "Others")) ///
       ylabel(0(0.1)1, format(%10.0g) angle(horizontal)) xlabel(, format(%10.0g)) ///
       title("Participation Rate Trends for Married Females by Education Level",size(3)) ///
       note("Participation rate: Share of active married females, weighted by W, by education level") ///
       graphregion(color(white))
graph export "1-2-1.png", replace	   
* bar chart for better visualization
graph bar (asis) ParticipationRateEduYear1 ParticipationRateEduYear2 ParticipationRateEduYear3 ///
ParticipationRateEduYear4 ParticipationRateEduYear5 ParticipationRateEduYear6 ///
ParticipationRateEduYear7 ParticipationRateEduYear8 ParticipationRateEduYear9, ///
over(Year, label(angle(0) labsize(vsmall))) legend(order(1 "Primary" 2 "Middle School" 3 "High School" 4 "Post Secondary" ///
5 "Associate Degree" 6 "College" 7 "Graduate-Master" 8 "Graduate-PHD" 9 "Others")) ///
ylabel(0(0.1)1, format(%10.0g) angle(horizontal)) ///
title("Participation Rate Trends for Married Females by Education Level",size(3)) ///
note("Participation rate: Share of active married females, weighted by W, by education level") ///
bar(1, color(red)) bar(2, color(green)) bar(3, color(blue)) bar(4, color(orange)) ///
bar(5, color(purple)) bar(6, color(magenta)) bar(7, color(yellow)) bar(8, color(cyan)) bar(9, color(black))
* Export the graph as a PNG file
graph export "1-2-2.png", replace
	   
************************************************************************Q1-3 the trend of female participation rate across provinces
* Calculate the weighted participation for each province level by year
use "Q1.dta", clear

egen  TotalWeightProvince = sum(W), by(Year prov)
egen ActiveWeightProvince = sum(W * IsActive), by(Year prov)

* Calculate the participation rates by province level and year
gen  ParticipationRateProvince =   100*ActiveWeightProvince/TotalWeightProvince
 

* Collapse the data to have one observation per province level per year
collapse (mean)  ParticipationRateProvince , by(Year prov)
reshape wide ParticipationRate, i(prov) j(Year)

* Replace numeric province codes with labels for readability in the table
label values prov Province
 
export excel using "WomenParticipationByProvince.xlsx", replace
 
 
 *************************************************************Q2 iranians' consumption analysis
 
 ****************************************preparing data for Q2 inclusing P3S01 and P3S03 forms
  
use "CombinedP3S01Fruits.dta",clear
 
merge m:1 Address Year using "CombinedP3S03Clothes.dta"
drop _merge
merge 1:1 Address Year using "Family_Size.dta"
drop _merge
save "Q2.dta", replace
gen Fruit_Exp_Capita = FruitExpenditure/Family_Size
 

  
 
*CPI from Central Bank of Iran-Base year 1395****************to calculate real values	
gen CPI = 0
replace CPI = 640.225 if Year==1401
replace CPI = 437.042 if Year==1400
replace CPI = 298.858 if Year==1399
replace CPI = 203.15  if Year==1398
	
	
// per capita
gen Real_Fruit_Capita = Fruit_Exp_Capita/CPI 
 
 
 

***********************************************************plotting	and creating per capita consumption across years and groups
********************************************************Fruit consumption  accross regions and years
use "Q2.dta", clear

* Calculate weighted real fruit capita for urban, rural, and total
egen Urban_Total_W = total(W * (UR == 1)), by(Year)
egen Urban_Total_Fruit_Exp_W = total(Real_Fruit_Capita * W * (UR == 1)), by(Year)
egen Rural_Total_W = total(W * (UR == 0)), by(Year)
egen Rural_Total_Fruit_Exp_W = total(Real_Fruit_Capita * W * (UR == 0)), by(Year)
egen Total_W = total(W), by(Year)
egen Total_Fruit_Exp_W = total(Real_Fruit_Capita * W), by(Year)

* Calculate weighted real fruit capita for urban, rural, and total
gen Urban_Weighted_Real_Fruit_Capita = Urban_Total_Fruit_Exp_W / Urban_Total_W if UR == 1
replace Urban_Weighted_Real_Fruit_Capita = . if missing(Urban_Weighted_Real_Fruit_Capita)
gen Rural_Weighted_Real_Fruit_Capita = Rural_Total_Fruit_Exp_W / Rural_Total_W if UR == 0
replace Rural_Weighted_Real_Fruit_Capita = . if missing(Rural_Weighted_Real_Fruit_Capita)
gen Total_Weighted_Real_Fruit_Capita = Total_Fruit_Exp_W / Total_W

* Collapse to get one observation per year for each group
collapse (mean) Urban_Weighted_Real_Fruit_Capita Rural_Weighted_Real_Fruit_Capita Total_Weighted_Real_Fruit_Capita, by(Year)

 

* Generate the bar chart 
graph bar (mean) Urban_Weighted_Real_Fruit_Capita Rural_Weighted_Real_Fruit_Capita Total_Weighted_Real_Fruit_Capita, over(Year) ///
    legend(label(1 "Urban") label(2 "Rural") label(3 "Total")) ///
    blabel(bar, position(outside) size(small)) ylabel(, format(%10.0g) ) ///
    title("Per Capita Real Fruit Consumption(Rials) per month Rate by Area and Year",size(3)) ///
    note("Weighted averages calculated for urban, rural, and total categories, adjusted for CPI in 1395.") ///
    bar(1, color(blue)) bar(2, color(green)) bar(3, color(red))
 
* Export the graph
 
graph export "2-1-1.png", replace
	   
 * Generate the line chart
twoway (line Urban_Weighted_Real_Fruit_Capita Year, lcolor(blue) lwidth(medium)) ///
       (line Rural_Weighted_Real_Fruit_Capita Year, lcolor(green) lwidth(medium)) ///
       (line Total_Weighted_Real_Fruit_Capita Year, lcolor(red) lwidth(medium)), ///
       legend(label(1 "Urban") label(2 "Rural") label(3 "Total")) ///
       ylabel(, format(%10.0g) ) xlabel(, valuelabel format(%10.0g)) ///
       title("Trend of Per Capita Real Fruit Consumption per month Rate(Rials) by Area",size(3)) ///
       note("Trends represented for urban, rural, and total categories, adjusted for CPI") ///
       graphregion(color(white)) plotregion(color(white))
* Export the graph
graph export "2-1-2.png", replace
	
 

***************************************************************************
* Load the Q2 dataset
use "Q2.dta", clear

* Adjusting for inflation to calculate real values of clothing expenditure per household
gen CPI = 0
replace CPI = 640.225 if Year == 1401
replace CPI = 437.042 if Year == 1400
replace CPI = 298.858 if Year == 1399
replace CPI = 203.15 if Year == 1398

gen Real_Clothes_Exp_Household = ClothesExpenditure / CPI

*Calculate weighted real fruit capita for urban, rural, and total
egen Urban_Total_W = total(W * (UR == 1)), by(Year)
egen Urban_Total_Clothes_Exp_W = total(Real_Clothes_Exp_Household  * W * (UR == 1)), by(Year)
egen Rural_Total_W = total(W * (UR == 0)), by(Year)
egen Rural_Total_Clothes_Exp_W = total(Real_Clothes_Exp_Household * W * (UR == 0)), by(Year)
egen Total_W = total(W), by(Year)
egen Total_Clothes_Exp_W = total(Real_Clothes_Exp_Household * W), by(Year)

* Calculate weighted real fruit capita for urban, rural, and total
gen Urban_Weighted_Real_Clothes = Urban_Total_Clothes_Exp_W / Urban_Total_W if UR == 1
replace Urban_Weighted_Real_Clothes= . if missing(Urban_Weighted_Real_Clothes)
gen Rural_Weighted_Real_Clothes = Rural_Total_Clothes_Exp_W / Rural_Total_W if UR == 0
replace Rural_Weighted_Real_Clothes = . if missing(Rural_Weighted_Real_Clothes)
gen Total_Weighted_Real_Clothes = Total_Clothes_Exp_W / Total_W

* Collapse to get one observation per year for each group
collapse (mean) Urban_Weighted_Real_Clothes Rural_Weighted_Real_Clothes Total_Weighted_Real_Clothes, by(Year)

 

* Generate the bar chart 
graph bar (mean) Urban_Weighted_Real_Clothes Rural_Weighted_Real_Clothes Total_Weighted_Real_Clothes, over(Year) ///
    legend(label(1 "Urban") label(2 "Rural") label(3 "Total")) ///
    blabel(bar, position(outside) size(small)) ylabel(, format(%10.0g) ) ///
    title("Per Household Real Clothes Consumption(Rials) per month Rate by Area and Year",size(3)) ///
    note("Weighted averages calculated for urban, rural, and total categories, adjusted for CPI in 1395.") ///
    bar(1, color(blue)) bar(2, color(green)) bar(3, color(red))
 
* Export the graph
graph export "2-2-1.png", replace
	   
 * Generate the line chart
twoway (line Urban_Weighted_Real_Clothes Year, lcolor(blue) lwidth(medium)) ///
       (line Rural_Weighted_Real_Clothes Year, lcolor(green) lwidth(medium)) ///
       (line Total_Weighted_Real_Clothes Year, lcolor(red) lwidth(medium)), ///
       legend(label(1 "Urban") label(2 "Rural") label(3 "Total")) ///
       ylabel(, format(%10.0g) ) xlabel(, valuelabel format(%10.0g)) ///
       title("Trend of Per Household Real Clothes Consumption per month Rate(Rials) by Area",size(3)) ///
       note("Trends represented per Household for urban, rural, and total categories, adjusted for CPI in 1395") ///
       graphregion(color(white)) plotregion(color(white))


* Export the bar chart
graph export "2-2-2.png", replace

 
	   
**************************************Q3-1 percentag eo f housing type*************************************	
 * `Type_Housing` has been created to categorize housing types

* Calculate the total weights by area and year

use  "CombinedP2Housing.dta", clear
 
gen  Type_Housing = "Owned" if Housing_Type==1 | Housing_Type==2
replace Type_Housing = "Rent" if Housing_Type==3
replace Type_Housing = "Mortgage" if Housing_Type==4
replace Type_Housing = "others" if Housing_Type>=5 & Housing_Type<.
egen Total_W_urban = total(W * (UR == 1)), by(Year)
egen Total_W_rural = total(W * (UR == 0)), by(Year)
egen Total_W = total(W), by(Year)

* Calculate the weighted counts for each housing type by area and year
egen Owned_W_urban = total(W * (Type_Housing == "Owned") * (UR == 1)), by(Year)
egen Rented_W_urban = total(W * (Type_Housing == "Rent") * (UR == 1)), by(Year)
egen Mortgaged_W_urban = total(W * (Type_Housing == "Mortgage") * (UR == 1)), by(Year)

egen Owned_W_rural = total(W * (Type_Housing == "Owned") * (UR == 0)), by(Year)
egen Rented_W_rural = total(W * (Type_Housing == "Rent") * (UR == 0)), by(Year)
egen Mortgaged_W_rural = total(W * (Type_Housing == "Mortgage") * (UR == 0)), by(Year)

egen Owned_W_total = total(W * (Type_Housing == "Owned")), by(Year)
egen Rented_W_total = total(W * (Type_Housing == "Rent")), by(Year)
egen Mortgaged_W_total = total(W * (Type_Housing == "Mortgage")), by(Year)

* Calculate percentages
gen Percent_Owned_Urban = Owned_W_urban / Total_W_urban * 100
gen Percent_Rented_Urban = Rented_W_urban / Total_W_urban * 100
gen Percent_Mortgaged_Urban = Mortgaged_W_urban / Total_W_urban * 100

gen Percent_Owned_Rural = Owned_W_rural / Total_W_rural * 100
gen Percent_Rented_Rural = Rented_W_rural / Total_W_rural * 100
gen Percent_Mortgaged_Rural = Mortgaged_W_rural / Total_W_rural * 100

gen Percent_Owned_Total = Owned_W_total / Total_W * 100
gen Percent_Rented_Total = Rented_W_total / Total_W * 100
gen Percent_Mortgaged_Total = Mortgaged_W_total / Total_W * 100

* Collapse to get one observation per year for each group
collapse (mean) Percent_Owned_Urban Percent_Rented_Urban Percent_Mortgaged_Urban ///
Percent_Owned_Rural Percent_Rented_Rural Percent_Mortgaged_Rural ///
Percent_Owned_Total Percent_Rented_Total Percent_Mortgaged_Total, by(Year)



* bar chart for Urban data
graph bar (mean) Percent_Owned_Urban Percent_Rented_Urban Percent_Mortgaged_Urban, over(Year) ///
    legend(label(1 "Owned") label(2 "Rented") label(3 "Mortgaged")) ///
    ylabel(0(10)100) title("Urban Housing Type Distribution by Year") ///
    note("Percentages of housing types in urban areas, adjusted for household weight.") 
    ytitle("Percentage") 
graph export "3-1-1.png", replace

graph bar (mean) Percent_Owned_Rural Percent_Rented_Rural Percent_Mortgaged_Rural, over(Year) ///
    legend(label(1 "Owned") label(2 "Rented") label(3 "Mortgaged")) ///
    ylabel(0(10)100) ///
    ytitle("Percentage") ///
    title("Rural Housing Type Distribution by Year") 
    note("Percentages of housing types in rural areas, adjusted for household weight.")
graph export "3-1-2.png", replace



graph bar (mean) Percent_Owned_Total Percent_Rented_Total Percent_Mortgaged_Total, over(Year) ///
    legend(label(1 "Owned") label(2 "Rented") label(3 "Mortgaged")) ///
    ylabel(0(10)100) ///
    ytitle("Percentage") ///
    title("Total Housing Type Distribution by Year") ///
    note("Percentages of housing types in total, adjusted for household weight.")
graph export "3-1-3.png", replace

*******************************Q3-2***changes in assumenda and real wage in the recent years
 
use "CombinedP3S04Housings.dta", clear 
*Adjusting for inflation to calculate real values of rent expenditure per household
gen CPI = 0
replace CPI = 640.225 if Year == 1401
replace CPI = 437.042 if Year == 1400
replace CPI = 298.858 if Year == 1399
replace CPI = 203.15 if Year == 1398

egen Urban_Total_W = total(W * (UR == 1)), by(Year)
egen Urban_Total_Rent_Exp_W = total(RentExpenditure * W * (UR == 1)), by(Year)
egen Rural_Total_W = total(W * (UR == 0)), by(Year)
egen Rural_Total_Rent = total(RentExpenditure * W * (UR == 0)), by(Year)
egen Total_W = total(W), by(Year)
egen Total_Rent = total(RentExpenditure  * W), by(Year)

* Calculate weighted real fruit capita for urban, rural, and total
gen Urban_Weighted_Real_Rent = Urban_Total_Rent / Urban_Total_W if UR == 1
replace Urban_Weighted_Real_Rent = . if missing(Urban_Weighted_Real_Rent)
gen Rural_Weighted_Real_Rent = Rural_Total_Rent / Rural_Total_W if UR == 0
replace Rural_Weighted_Real_Rent = . if missing(Rural_Weighted_Real_Rent)
gen Total_Weighted_Real_Rent = Total_Rent / Total_W

* Collapse to get one observation per year for each group
collapse (mean) Urban_Weighted_Real_Rent Rural_Weighted_Real_Rent Total_Weighted_Real_Rent, by(Year)
 
graph bar (mean) Urban_Weighted_Real_Rent Rural_Weighted_Real_Rent Total_Weighted_Real_Rent, over(Year) ///
    legend(label(1 "Urban") label(2 "Rural") label(3 "Total")) ///
    blabel(bar, position(outside) size(small)) ///
    ylabel(, format(%10.0gc) labsize(vsmall)) ///
    title("Trend of Real and Assumed Rent per Month Rate (Rials) by Area", size(3)) ///
    note("Weighted averages calculated for urban, rural, and total categories, adjusted for CPI in 1395.") ///
    bar(1, color(blue)) bar(2, color(green)) bar(3, color(red)) ///
    ytitle("Rent Expenditure (Rials)") 
* Export the graph
graph export "3-2-1.png", replace   

* Generate the line chart
twoway (line Urban_Weighted_Real_Rent Year, lcolor(blue) lwidth(medium)) ///
       (line Rural_Weighted_Real_Rent Year, lcolor(green) lwidth(medium)) ///
       (line Total_Weighted_Real_Rent Year, lcolor(red) lwidth(medium)), ///
       legend(label(1 "Urban") label(2 "Rural") label(3 "Total")) ///
       ylabel(, format(%10.0gc) labsize(vsmall)) xlabel(, valuelabel format(%10.0g)) ///
       title("Trend of Real and Assumed Rent per month Rate(Rials) by Area",size(3)) ///
       note("Trends represented for urban, rural, and total categories, adjusted for CPI in 1395") 
       graphregion(color(white)) plotregion(color(white))
* Export the graph  

graph export "3-2-2.png", replace
**************************************************************Working on summary data for Q 4-1 and Q 4-2

 *********************************************************** Q4 Data Prepration****************************************************************

cd "C:\Users\fatem\Downloads\Stata\HIES\Code"
clear
foreach x in R U{
	   forvalues i=80(1)100{
		   clear
			if `i'!=100{
			    import excel "Sum`x'`i'.xlsx", sheet("Sum`x'`i'") firstrow case(lower)
			}
			if `i'==100{
			  import excel "Sum`x'`i'.xlsx", firstrow case(lower)  
			}
			ren vgheir* vgheirkhorak
			keep vkhorak vgheirkhorak nhazineh weight c01
			destring c01 vkhorak vgheirkhorak nhazineh weight, replace force
			gen Year = `i'
			gen UR = "`x'"
			save "Sum`x'`i'.dta", replace	
		}
	}
					

********************************************************* Merge Data *******************************************************************
clear
foreach x in U R{
	   forvalues i=80(1)100{
		append using "Sum`x'`i'.dta"
		}
	}
*******************************************************Data  Cleaning for Q4-1************************************
ren c01 Size
ren nhazineh Net_Expenditure
ren vkhorak Vkhorak
ren vgheirkhorak Vgheirkhorak 
ren weight Weight
replace Year=1300+Year if Year!=1400
gen Total_Expenditure=(Vkhorak+Vgheirkhorak)/Size
lab var Size "Household Size"
lab var Net_Exp "Pure Cost"
lab var Total_Expenditure "Total Expenditures"
save "Q4-1.dta", replace
	
	
************************************************Creating Deciles ********************************************************************
clear
use  "Q4-1.dta"
	
	gen Decile_Expenditure_All = .
	forvalues i=1380(1)1400{
	    xtile 	Decile_Expenditure_`i' = Total_Expenditure if Year==`i', nq(10) 
		replace Decile_Expenditure_All = Decile_Expenditure_`i' if Year==`i'& Decile_Expenditure_All==.
		drop 	Decile_Expenditure_`i' 
	}
	
save "Q4-1-Decile.dta", replace
	
************************************************Average cost per decile**********************************************************
collapse (mean) Total_Expenditure [aw=Weight], by(Year Decile_Expenditure_All)	
drop if Decile_Expenditure_All!=1 & Decile_Expenditure_All!=10
sort Year Decile_Expenditure_All
by Year: gen Decile_10_to_1_All = Total_Expenditure[2]/Total_Expenditure[1]
duplicates drop Year, force
save "Decile_10_to_1_All.dta", replace

************************************************* Income Deciles across rural and urban*********************************************
clear
use  "Q4-1-Decile.dta"
	gen Decile_Expenditure_U = .
	gen Decile_Expenditure_R = .
	forvalues i=1380(1)1400{
	    foreach x in U R{
		    xtile 	Decile_Expenditure_`x'_`i' = Total_Expenditure if Year==`i' & UR=="`x'", nq(10) 
			replace Decile_Expenditure_`x' = Decile_Expenditure_`x'_`i' if Year==`i' & UR=="`x'" & Decile_Expenditure_`x' ==.
			drop 	Decile_Expenditure_`x'_`i' 
		}
	}
	
*****************************************************Average cost per decile across rural and urban*************************************
collapse (mean) Total_Expenditure [aw=Weight], by(Year Decile_Expenditure_U Decile_Expenditure_R)
keep if ((Decile_Expenditure_U==1 | Decile_Expenditure_U==10) & Decile_Expenditure_R==.) | ((Decile_Expenditure_R==1 | Decile_Expenditure_R==10) & Decile_Expenditure_U==.)
*Sort for urban*****************************************************************
sort Year Decile_Expenditure_U
by Year: gen Decile_10_to_1_U = Total_Expenditure[2]/Total_Expenditure[1]
*Sort for rural***************************************************************** 
sort Year Decile_Expenditure_R
by Year: gen Decile_10_to_1_R = Total_Expenditure[2]/Total_Expenditure[1]
drop Decile_Expenditure_U Decile_Expenditure_R Total_Expenditure
duplicates drop Year, force
	
* append ***********************************************************************
merge 1:1 Year using "Decile_10_to_1_All.dta"

twoway (line Decile_10_to_1_All Year, lcolor(black)) ///
       (line Decile_10_to_1_U Year, lcolor(blue)) ///
       (line Decile_10_to_1_R Year, lcolor(red)), ///
       legend(label(1 "Total") label(2 "Urban") label(3 "Rural")) ///
       xlabel(1380(1)1400, angle(vertical)) ///
       ytitle("10th/1st Expenditure Ratio") ///
       xtitle("Year")
graph export "4-1.png", replace

	 
* ******************************************************Q4-2 ***************************************************************************

clear
cd "C:\Users\fatem\Downloads\Stata\HIES\Code"
import excel "SumR100.xlsx",clear firstrow     
gen UR=0
save SumR100 , replace
import excel "SumU100.xlsx",clear firstrow  
gen UR=1
save SumU100 , replace
 
********************************************************Merging Data******************************************************************
use "SumR100", clear
append using SumU100 , force 
keep VKhorak VGheirehKhorak NHazineh weight C01 UR
destring VKhorak VGheirehKhorak NHazineh weight C01 UR , replace force
ren C01 Size
ren NHazineh Net_Expenditure
ren weight Weight
gen Total_Expenditure=(VKhorak+VGheirehKhorak)/Size
lab var Size "Household Size"
lab var Net_Expenditure "Pure Cost"
lab var Total_Expenditure "Total Expenditures"
save "Q4-2.dta", replace
********************************************************Creating Quaartiles****************************
preserve
xtile Percentile_Expenditure = Total_Expenditure, nq(100)
collapse (mean) Total_Expenditure_All = Total_Expenditure [aw=Weight], by(Percentile_Expenditure)
save "Percentile_Expenditure_All_1400.dta",replace
restore
*********************************************For Urban Households ********************************
preserve
keep if UR==1
xtile Percentile_Expenditure = Total_Expenditure, nq(100)
collapse (mean) Total_Expenditure_U = Total_Expenditure [aw=Weight], by(Percentile_Expenditure)
save "Percentile_Expenditure_U_1400.dta",replace
restore
*********************************************For Rural Households*******************************
keep if UR==0
xtile Percentile_Expenditure = Total_Expenditure, nq(100)
collapse (mean) Total_Expenditure_R = Total_Expenditure [aw=Weight], by(Percentile_Expenditure)
************************************Merging across Urban and Rural Households****************************
merge 1:1 Percentile_Expenditure using "Percentile_Expenditure_U_1400.dta"
drop _merge
merge 1:1 Percentile_Expenditure using "Percentile_Expenditure_All_1400.dta"
drop _merge
*********************************Creating Proportions of Percentiles****************************************
tsset Percentile_Expenditure
gen lag_R = l.Total_Expenditure_R
gen Percentile_R = Total_Expenditure_R/lag_R
	
gen lag_U = l.Total_Expenditure_U
gen Percentile_U = Total_Expenditure_U/lag_U
	
gen lag_All = l.Total_Expenditure_All
gen Percentile_All = Total_Expenditure_All/lag_All
	
*******************************Generating Graph*********************************************************************
twoway (line Percentile_All Percentile_Expenditure, sort lc(black) lw(medium)) ///
       (line Percentile_U Percentile_Expenditure, sort lc(blue) lw(medium)) ///
       (line Percentile_R Percentile_Expenditure, sort lc(red) lw(medium)), ///
       legend(order(1 "Total" 2 "Urban" 3 "Rural") nobox region(lstyle(none)) cols(1)) ///
       ylabel(, format(%10.0g) labsize(small)) ///
       xlabel(, labsize(small)) ///
       ytitle("n+1th/nth Expenditure Ratio", size(medium)) ///
       xtitle("Percentile", size(medium)) ///
       title("Household Expenditure Ratio by Percentile", size(large)) ///
       note("Ratio of n+1th to nth expenditure across percentiles; adjusted for household weight.", size(small)) 
       graphregion(color(white)) plotregion(color(white));
 
* Export the enhanced graph
graph export "4-2.png", replace;




