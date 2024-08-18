/********************************************************************************
Title: LFS Project
*Course: Microeconometrics
*Author: Fatemeh Abbasian
*StudentID: 400100338
********************************************************************************/




clear
set more off


cd "C:\Users\fatem\Downloads\Stata\LFS"
*\odbc list
*\odbc query "LFS1401111", dialog(complete)
*\odbc desc "LFS_RawData"
save "LFS1401.dta",replace
use "LFS1401.dta",clear

*renaming columns
rename IW_Yearly w
rename F2_D03 Relativeness
rename F2_D04 Sex
rename F2_D07 Age
rename F2_D08 Nationality
rename F2_D09 Presence
rename F2_D10 MovingAttr1
rename F2_D11 MovingAttr2
rename F2_D12 MovingAttr3
rename F2_D13 MovingAttr4
rename F2_D14 MovingAttr5
rename F2_D15 IfCurrStudy
rename F2_D16 Lit
rename F2_D17 YearsOfEdu
rename F2_D18 Field
rename F2_D19 Marital
rename F3_D01 WorkForPay
rename F3_D02 WorkForPayH
rename F3_D03 WorkForPayForFam
rename F3_D04 WorkForPayForFamDurable
rename F3_D05 Intern
rename F3_D06 TempnotWork
rename F3_D07 TempnotWorkReason
rename F3_D08 OtherJob
rename F3_D09 JobTit
rename F3_D10 GoodCode
rename F3_D11 JobPos
rename F3_D12 NumofPeer
rename F3_D13 Insurance
rename F3_D14SAL CurrJobExpY
rename F3_D14MAH CurrJobExpM
rename F3_D15SAL AllJobExpY
rename F3_D15MAH ALLJobExpM
rename F3_D16SHASLIR CurrJobDperW
rename F3_D16SHASLIS CurrJobHperW
rename F3_D16SHHAMRO SumCurrJobDperW
rename F3_D16SHHAMSA SumCurrJobHperW
rename F3_D17 HperWReason
rename F3_D18SHANBEH LWSatH
rename F3_D18YEKSHAN LWSunH
rename F3_D18DOSHANB LWMonH
rename F3_D18SESHANB LWTueH
rename F3_D18CHARSHA LWWedH
rename F3_D18PANSHAN LWThuH
rename F3_D18JOMEH LWFriH
rename F3_D18JAM LWSumH
rename F3_D19 LessReason
rename F3_D20 MoreReason
rename F3_D21 DesiForMore
rename F3_D22 PrepForMore
rename F3_D23 MoreChan
rename F3_D24 EmpSearchStat
rename F3_D25 EmpSearchReason
rename F3_D26 EmpSearchChan
rename F3_D27ROZ NextSeasonDesireDperW
rename F3_D27SAAT NextSeasonDesireHperW
rename F3_D28 SecondJobTit
rename F3_D29 SecondGoodCode
rename F3_D30 SecondJobPos
rename F3_D31 UnempSearchStat
rename F3_D1_32 UnempSearchGov
rename F3_D2_32 UnempSearchNGov
rename F3_D3_32 UnempSearchCalCEO
rename F3_D4_32 UnempSearchFreFam
rename F3_D5_32 UnempSearchSelFin
rename F3_D6_32 UnempSearchLicen
rename F3_D7_32 UnempSearchNewsp
rename F3_D8_32 UnempSearchOth
rename F3_D9_32 UnempNotSearch
rename F3_D33 UnempNotSearchChan
rename F3_D34 PrepByWeekend
rename F3_D35SAL UnempSearchDurY
rename F3_D35MAH UnempSearchDurM
rename F3_D36 UnempSearchPreStat
rename F3_D37SAL UnempSumExperY
rename F3_D37MAH UnempSumExperM
rename F3_D38 UIStat
rename F3_D39 ExpInFiveY
rename F3_D40SAL SinceLastExpY
rename F3_D40MAH SinceLastExpM
rename F3_D41 LastJobTit
rename F3_D42 LastGoodCode
rename F3_D43 LastJobPos
rename F3_D44 ReleaseReason
rename F3_D45 PrepByWeekend2
rename F3_D46 NotPrepByWeekendChan
rename F3_D47 UnempLastWeekPos
rename F3_D48SAAT NextJobDesiredHperW
rename F3_D48ROZ NextJobDesiredDperW
rename F3_D49 NextJobType
rename F3_D50 NextJobSector
gen year = substr(pkey,1,2)
label variable year "Year"
destring year, replace
destring Insurance, replace force 
 
* Extracting province codes from 'pkey' and converting them to readable names
*This block of code is designed to handle the conversion of province codes within a unique identifier (pkey) to human-readable province names. It enhances the interpretability of the data by replacing numeric codes with descriptive labels for each province, facilitating more intuitive data analysis and reporting.
gen prov = substr(pkey,3,2)
label variable prov "Province"
destring prov, replace
label define Province 0 "Markazi" 1 "Gilan" 2 "Mazandaran" 3 "Azarbayjan-E-Sharghi" 4 "Azarbayjan-E-Gharbi" 5 "Kermanshah" 6 "Khouzestan" 7 "Fars" 8 "Keramn" 9 "Khorasan-E-Razavi" 10 "Isfahan" 11 "Sistan-va-Balouchestan" 12 "Kordestan" 13 "Hamedan" 14 "Bakhtyari" 15 "Lorestan" 16 "Ilam" 17 "Kohkilouye" 18 "Boushehr" 19 "Zanjan" 20 "Semnan" 21 "Yazd" 22 "Hormozgan" 23 "Tehran" 24 "Ardabil" 25 "Qom" 26 "Qazvin" 27 "Golestan" 28 "Khorasan-E-Shomali" 29 "Khorasan-E-Jonoubi" 30 "Alborz" 
label values prov Province
*tab prov
gen U_R = substr(pkey,5,1)
label variable U_R "Urban Condition"
destring U_R, replace
label define Urban_Condition 1 "Urban" 2 "Rural"
label values U_R Urban_Condition
gen IsUrban=0
replace IsUrban=1 if U_R==1
gen IsRural=0
replace IsRural=1 if U_R==2
* Processing the 'Sex' variable for gender categorization
destring Sex, replace
replace Sex = 0 if Sex == 2
gen IsMale=0
replace IsMale=1 if Sex==1
gen IsFemale=0
replace IsFemale=1 if Sex==0
destring JobPos, replace force
* Identify wage earners individuals for further analysis
gen wageeraner=0
replace wageeraner=1 if JobPos==4 | JobPos==5 | JobPos==6 | JobPos==7 | JobPos==9
* Identify self-employed individuals for further analysis
gen selfemployed=0
replace selfemployed=1 if JobPos==1 | JobPos==2 | JobPos==3 
* Identify individuals for public sector for further analysis
gen public=0
replace public=1 if JobPos==5 | JobPos==7 | JobPos==8
* Identify  individuals for privatate sector for further analysis
gen private=0
replace private=1 if JobPos==4 | JobPos==9 | JobPos==10


* Idetermining each individual total and current job experience duaration
destring CurrJobExpY,replace
destring CurrJobExpM,replace
gen CurrJobExp = CurrJobExpY + CurrJobExpM/12
destring AllJobExpY,replace
destring ALLJobExpM,replace
gen AllJobExp = AllJobExpY + ALLJobExpM/12





gen Code=substr(GoodCode,1,2)
gen ind_type = 0
forvalues ind_num = 1(1)3{
replace ind_type = 1 if ( Code== "0`ind_num'")
}

forvalues ind_num = 5(1)9{
replace ind_type = 2 if (Code== "0`ind_num'")
}

forvalues ind_num = 10(1)43{
replace ind_type = 2 if (Code== "`ind_num'")
}

forvalues ind_num = 45(1)99{
replace ind_type = 3 if (Code== "`ind_num'")
}
* Label sectors for ease of reference in analysis
gen IsAgr=0
replace IsAgr=1 if ind_type==1

gen IsInd=0
replace IsInd=1 if ind_type==2

gen IsSrv=0
replace IsSrv=1 if ind_type==3
* Processing education level data for analysis
*This code segment is designed to process the 'YearsOfEdu' variable, which quantifies the number of years of education an individual has completed. Initially, it ensures that 'YearsOfEdu' is in a numeric format, enabling numerical operations and comparisons. Subsequently, it introduces a binary variable 'HigherEdu' to distinguish individuals with a higher level of education. Specifically, it identifies those who have completed between 5 to 9 years of education as having higher education, which likely corresponds to completing secondary education and possibly some post-secondary education. This binary categorization facilitates further analysis focused on assessing the impact or correlation of higher educational attainment within the dataset's context.
destring YearsOfEdu,replace
gen HigherEdu=0
replace HigherEdu=1 if YearsOfEdu==5 | YearsOfEdu==6 | YearsOfEdu==7 | YearsOfEdu==8 | YearsOfEdu==9
* Adjusting the 'Age' variable for employment analysis
*This code snippet processes the 'Age' variable to ensure it is in a numeric format suitable for analysis, then filters out individuals under the age of 15. This action is taken because, in the context of employment studies within Iran, individuals are considered part of the labor force starting from the age of 15. This aligns with many international standards, including those of the International Labour Organization (ILO), which often categorize the working-age population as those aged 15 and above. By removing younger individuals, the dataset is refined to focus only on the portion of the population relevant to employment analysis, ensuring the accuracy and relevancy of subsequent findings.
destring Age, replace
drop if Age < 15
destring ActivityStatus, replace 
gen active=0
replace active=1 if ActivityStatus==1 | ActivityStatus ==2 
gen unemployed=0
replace unemployed=1 if ActivityStatus ==2 

 
* Processing activity status to categorize individuals based on their employment status
* Define active and employed indicators
gen isActive = inlist(ActivityStatus, 1, 2)
gen isEmployed = (ActivityStatus == 1)

* Calculate the weighted sum of active and employed individuals
egen totalWeight = total(w)
egen totalActiveW = total(w * isActive)
egen totalEmployedW = total(w * isEmployed)

* Calculate participation and unemployment rates
gen participationRate =100 * totalActiveW / totalWeight
gen unemploymentRate = 100 * (totalActiveW - totalEmployedW) / totalActiveW

* Display corrected overall rates
disp "Overall Participation Rate: " participationRate
disp "Overall Unemployment Rate: " unemploymentRate


* Calculate and display participation and unemployment rates by gender
foreach sex in 0 1 {  // Assuming 0 is female and 1 is male
    * Calculate weights for active and employed individuals by gender
    egen activeW_`sex' = total(w * isActive * (Sex == `sex'))
    egen employedW_`sex' = total(w * isEmployed * (Sex == `sex'))
    egen totalW_`sex' = total(w * (Sex == `sex'))

    * Calculate participation and unemployment rates by gender
    gen participationRate_`sex' = 100 * activeW_`sex' / totalW_`sex'
    gen unemploymentRate_`sex' = 100 *(activeW_`sex' - employedW_`sex') / activeW_`sex'

    * Display rates by gender
    disp "Participation Rate for Sex=`sex': " participationRate_`sex'
    disp "Unemployment Rate for Sex=`sex': " unemploymentRate_`sex'
}

* Adjusting for the age group 20 to 35
gen ageGroup20_35 = Age >= 20 & Age <= 35
egen activeW_ageGroup20_35 = total(w * isActive * ageGroup20_35)
egen employedW_ageGroup20_35 = total(w * isEmployed * ageGroup20_35)
egen totalW_ageGroup20_35 = total(w * ageGroup20_35)
gen participationRate_ageGroup20_35 = 100 * activeW_ageGroup20_35 / totalW_ageGroup20_35
gen unemploymentRate_ageGroup20_35 = 100 * (activeW_ageGroup20_35 - employedW_ageGroup20_35) / activeW_ageGroup20_35
disp "Participation Rate for 20-35 years old: " participationRate_ageGroup20_35
disp "Unemployment Rate for 20-35 years old: " unemploymentRate_ageGroup20_35

* Adjusting for the age group 35 to 50
gen ageGroup35_50 = Age >= 35 & Age <= 50
egen activeW_ageGroup35_50 = total(w * isActive * ageGroup35_50)
egen employedW_ageGroup35_50 = total(w * isEmployed * ageGroup35_50)
egen totalW_ageGroup35_50 = total(w * ageGroup35_50)
gen participationRate_ageGroup35_50 = 100 * activeW_ageGroup35_50 / totalW_ageGroup35_50
gen unemploymentRate_ageGroup35_50 = 100 * (activeW_ageGroup35_50 - employedW_ageGroup35_50) / activeW_ageGroup35_50
disp "Participation Rate for 35-50 years old: " participationRate_ageGroup35_50
disp "Unemployment Rate for 35-50 years old: " unemploymentRate_ageGroup35_50

foreach ur in 1 2 {  // Assuming 1 is Urban and 2 is Rural
    egen activeW_UR_`ur' = total(w * isActive * (U_R == `ur'))
    egen employedW_UR_`ur' = total(w * isEmployed * (U_R == `ur'))
    egen totalW_UR_`ur' = total(w * (U_R == `ur'))
    gen participationRate_UR_`ur' = 100 * activeW_UR_`ur' / totalW_UR_`ur'
    gen unemploymentRate_UR_`ur' = 100 * (activeW_UR_`ur' - employedW_UR_`ur') / activeW_UR_`ur'

    * Correctly display the rates with conditional checks
    if `ur' == 1 {
        disp "Participation Rate for Urban: " participationRate_UR_`ur'
        disp "Unemployment Rate for Urban: " unemploymentRate_UR_`ur'
    }
    else if `ur' == 2 {
        disp "Participation Rate for Rural: " participationRate_UR_`ur'
        disp "Unemployment Rate for Rural: " unemploymentRate_UR_`ur'
    }
}



 
save "LFS1401Cleaned.dta",replace



* Example of setting up a dataset for plotting
clear
input str10 group float participationRate float unemploymentRate
"Overall"       40.86 9.01
"Men"           68.20 7.65
"Women"         13.60 15.80
"20-35 years"   50.22 16.16
"35-50 years"   55.0 5.20 
"Urban"         40.30 9.72
"Rural"         42.74  6.7
end

* Manually fill in the calculated rates for participationRate and employmentRate for each group
* This is a placeholder step - replace the dots with actual rates

* For demonstration, let's assume some example rates (in percentages for clarity):
 

graph bar (asis) participationRate unemploymentRate, over(group) ///
    legend(label(1 "Participation Rate (percent)") label(2 "Unemployment Rate (percent)")) ///
    ylabel(0(20)100, format(%g) angle(horizontal) grid) ///
    ytitle("Rate (%)") ///
    barwidth(0.5) blabel(bar, format(%9.2f)) ///
    title("Participation and Unemployment Rates by Group", size(medium))


	
	
use "LFS1401Cleaned.dta",clear	

destring Insurance, replace force 
 
* Calculate the weighted percentage for the total population
gen insuredHigherEdu = Insurance == 1 & HigherEdu == 1
egen totalInsuredWeight = sum(w * (Insurance == 1))
egen totalInsuredHigherEduWeight = sum(w * insuredHigherEdu)
gen pctTotalWeighted = 100 * totalInsuredHigherEduWeight / totalInsuredWeight
di "Percentage of insured individuals with higher education (Total): "  pctTotalWeighted

* Calculate the weighted percentage for women
egen totalInsuredWomenWeight = sum(w * (Insurance == 1 & Sex == 0))
egen totalInsuredHigherEduWomenWeight = sum(w * (insuredHigherEdu==1 & Sex == 0))
gen pctWomenWeighted = 100 * totalInsuredHigherEduWomenWeight / totalInsuredWomenWeight
 
* Display the percentage for women
di "Percentage of insured individuals with higher education (Women): " pctWomenWeighted
 
* Calculate the weighted percentage for men
egen totalInsuredMenWeight = sum(w * (Insurance == 1 & Sex == 1))
egen totalInsuredHigherEduMenWeight = sum(w * (insuredHigherEdu==1 & Sex == 1))
gen pctMenWeighted = 100 * totalInsuredHigherEduMenWeight / totalInsuredMenWeight
* Display the percentage for men
di "Percentage of insured individuals with higher education (Men): "  pctMenWeighted


 
summarize pctTotalWeighted pctWomenWeighted pctMenWeighted


* Assuming my dataset with calculated percentages is currently in memory
 
save "LFS1401Cleaned1.dta",replace
* Clear current data in memory and prepare for plotting (save your work before this step)
clear
input str10 group float percentage
"Total" 47.44
"Women" 83.40
"Men"   40.5
end
* Plotting the weighted percentages
graph bar percentage, over(group) title("Percentage of Insured Employed with University Education by Group", size(3))
graph export "2.png", replace


use "LFS1401Cleaned1.dta",clear
* Ensure you're using the cleaned dataset
 

* Generate indicator variables if not already present
gen isWomen = Sex == 0
gen isMen = Sex == 1

* Calculate weighted totals and insured counts for Total
egen totalPublic_total_wt = total((public==1) * w)
egen insuredPublic_total_wt = total((Insurance==1 & public==1) * w)
local pctInsuredPublic_total = 100 * insuredPublic_total_wt / totalPublic_total_wt

egen totalPrivate_total_wt = total((private==1)* w)
egen insuredPrivate_total_wt = total((Insurance==1 & private==1) * w)
local pctInsuredPrivate_total = 100 * insuredPrivate_total_wt / totalPrivate_total_wt

di "Weighted Public Sector - Total: " `pctInsuredPublic_total'
di "Weighted Private Sector - Total: " `pctInsuredPrivate_total'

* Calculate weighted totals and insured counts for Women
egen totalPublic_women_wt = total((public==1 & isWomen==1) * w)
egen insuredPublic_women_wt = total((Insurance==1 & public==1 & isWomen ==1)* w)
local pctInsuredPublic_women = 100 * insuredPublic_women_wt / totalPublic_women_wt

egen totalPrivate_women_wt = total((private==1 & isWomen==1) * w)
egen insuredPrivate_women_wt = total((Insurance==1 & private==1 & isWomen==1) * w)
local pctInsuredPrivate_women = 100 * insuredPrivate_women_wt / totalPrivate_women_wt

di "Weighted Public Sector - Women: " `pctInsuredPublic_women'
di "Weighted Private Sector - Women: " `pctInsuredPrivate_women'

* Calculate weighted totals and insured counts for Men
egen totalPublic_men_wt = total((public==1 & isMen==1) * w)
egen insuredPublic_men_wt = total((Insurance ==1 & public==1 & isMen==1) * w)
local pctInsuredPublic_men = 100 * insuredPublic_men_wt / totalPublic_men_wt

egen totalPrivate_men_wt = total((private==1 & isMen==1) * w)
egen insuredPrivate_men_wt = total((Insurance==1 & private==1 & isMen ==1)* w)
local pctInsuredPrivate_men = 100 * insuredPrivate_men_wt / totalPrivate_men_wt

di "Weighted Public Sector - Men: " `pctInsuredPublic_men'
di "Weighted Private Sector - Men: " `pctInsuredPrivate_men'

 
 
* Note: The actual plotting part has been simplified for clarity. To plot these values with labels, proceed as follows for public and private sectors.
save "LFS1401Cleaned2.dta",replace
* Now, prepare data and plot for public sector
clear
input str10 group float percentage
"Total" 97.76
"Women" 97.23
"Men"   97.94
end

* Plot for public sector with values displayed
 graph bar percentage, over(group) title("Percentage of Insured Employees in the Public Sector", size(3))



* Export the graph for public sector
graph export "6.png", replace

* Clear data in memory before plotting for the private sector
clear

* Prepare data and plot for private sector
input str10 group float percentage
"Total" 47.21
"Women" 47.67
"Men"   47.13
end

* Plot for private sector with values displayed
graph bar percentage, over(group) title("Percentage of Insured Employees in the Private Sector", size(3))



* Export the graph for private sector
graph export "7.png", replace


use "LFS1401Cleaned2.dta",clear
* Calculate the percentage of self-employed and wage earners in Agriculture
egen totalAgr = sum(w * (IsAgr==1))
egen selfEmployedAgr = sum(w * (IsAgr==1 & selfemployed==1))
egen wageEarnerAgr = sum(w * (IsAgr==1 & wageeraner==1))
gen pctSelfEmployedAgr = 100 * selfEmployedAgr / totalAgr
gen pctWageEarnerAgr = 100 * wageEarnerAgr / totalAgr

* Calculate the percentage of self-employed and wage earners in Industry
egen totalInd = sum(w * (IsInd==1))
egen selfEmployedInd = sum(w * (IsInd==1 & selfemployed==1))
egen wageEarnerInd = sum(w * (IsInd==1 & wageeraner==1))
gen pctSelfEmployedInd = 100 * selfEmployedInd / totalInd
gen pctWageEarnerInd = 100 * wageEarnerInd / totalInd

* Calculate the percentage of self-employed and wage earners in Services
egen totalSrv = sum(w * (IsSrv==1))
egen selfEmployedSrv = sum(w *(IsSrv==1 & selfemployed==1))
egen wageEarnerSrv = sum(w * (IsSrv==1 & wageeraner==1))
gen pctSelfEmployedSrv = 100 * selfEmployedSrv / totalSrv
gen pctWageEarnerSrv = 100 * wageEarnerSrv / totalSrv


* Display percentages for Agriculture sector
di "Percentage of Self-Employed in Agriculture: " pctSelfEmployedAgr "%"
di "Percentage of Wage Earners in Agriculture: " pctWageEarnerAgr "%"

* Display percentages for Industry sector
di "Percentage of Self-Employed in Industry: " pctSelfEmployedInd "%"
di "Percentage of Wage Earners in Industry: " pctWageEarnerInd "%"

* Display percentages for Services sector
di "Percentage of Self-Employed in Services: " pctSelfEmployedSrv "%"
di "Percentage of Wage Earners in Services: " pctWageEarnerSrv "%"

save "LFS1401Cleaned3.dta",replace
clear

 * Clear the workspace and prepare data for plotting
 
input str15 sector str15 employmentType float percentage
"Agriculture" "Self-Employed" 78.09
"Agriculture" "Wage Earner"   21.90
"Industry"    "Self-Employed" 29.12
"Industry"    "Wage Earner"   70.76
"Services"    "Self-Employed" 45.05
"Services"    "Wage Earner"  54.73
end

graph bar (asis) percentage, over(sector) by(employmentType) ytitle("Percentage") title("Employment Type by Sector")  
graph export "3.png", replace


* Handling 'NumofPeer' variable to categorize firms based on their size in terms of the number of peers/employees
destring NumofPeer, replace force
use "LFS1401Cleaned3.dta", clear
* Creating variables to categorize firms based on size
gen LessThan10Employer=0
replace LessThan10Employer=1 if NumofPeer==1 | NumofPeer==2

gen Between10and20Employer=0
replace Between10and20Employer=1 if NumofPeer==3

gen MoreThan20Employer=0
replace MoreThan20Employer=1 if NumofPeer==4 | NumofPeer==5

* Generate sector and firm size labels
generate sectorLabel = ""
replace sectorLabel = "Agriculture" if IsAgr == 1
replace sectorLabel = "Industry" if IsInd == 1
replace sectorLabel = "Services" if IsSrv == 1

generate firmSizeLabel = ""
replace firmSizeLabel = "Less than 10" if LessThan10Employer == 1
replace firmSizeLabel = "Between 10 and 20" if Between10and20Employer == 1
replace firmSizeLabel = "More than 20" if MoreThan20Employer == 1
* Example of creating readable label variables before collapsing
* This step assumes you've already generated sectorGroup and firmSize variables correctly
* Generate sector and firm size labels
collapse (sum) w, by(sectorLabel firmSizeLabel)

 * Filter for Agriculture and plot
keep if sectorLabel == "Agriculture"
graph bar w, over(firmSizeLabel) ///
    ytitle("Number of Employers") ///
    title("Number of Employers by Firm Size in Agriculture") ///
    ylabel(, format(%9.0g) labsize(small) angle(horizontal) grid) ///
    legend(label(1 "Less than 10") label(2 "Between 10 and 20") label(3 "More than 20"))
graph export "Agriculture.png", replace


use "LFS1401Cleaned3.dta", clear

gen LessThan10Employer=0
replace LessThan10Employer=1 if NumofPeer==1 | NumofPeer==2

gen Between10and20Employer=0
replace Between10and20Employer=1 if NumofPeer==3

gen MoreThan20Employer=0
replace MoreThan20Employer=1 if NumofPeer==4 | NumofPeer==5

* Generate sector and firm size labels
generate sectorLabel = ""
replace sectorLabel = "Agriculture" if IsAgr == 1
replace sectorLabel = "Industry" if IsInd == 1
replace sectorLabel = "Services" if IsSrv == 1

generate firmSizeLabel = ""
replace firmSizeLabel = "Less than 10" if LessThan10Employer == 1
replace firmSizeLabel = "Between 10 and 20" if Between10and20Employer == 1
replace firmSizeLabel = "More than 20" if MoreThan20Employer == 1
* Example of creating readable label variables before collapsing
* This step assumes you've already generated sectorGroup and firmSize variables correctly
* Generate sector and firm size labels
collapse (sum) w, by(sectorLabel firmSizeLabel)
* Filter for Industry and plot
keep if sectorLabel == "Industry"
graph bar w, over(firmSizeLabel) ///
    ytitle("Number of Employers") ///
    title("Number of Employers by Firm Size in Industry") ///
    ylabel(, format(%9.0g) labsize(small) angle(horizontal) grid) ///
    legend(label(1 "Less than 10") label(2 "Between 10 and 20") label(3 "More than 20"))
graph export "Industry.png", replace



use "LFS1401Cleaned3.dta", clear


* Set the survey design for the dataset, specifying `w` as the weight variable
svyset _n [pw=w]

* Calculate the average total job experience for all individuals, men and women in each sector
foreach sector of varlist IsAgr IsInd IsSrv {
    * For the whole population
    svy: mean AllJobExp if `sector' == 1
    di "Average total job experience in sector (`sector'): " _b[AllJobExp]
    
    * For women
    svy: mean AllJobExp if `sector' == 1 & Sex == 0
    di "Average total job experience for women in sector (`sector'): " _b[AllJobExp]
    
    * For men
    svy: mean AllJobExp if `sector' == 1 & Sex == 1
    di "Average total job experience for men in sector (`sector'): " _b[AllJobExp]
}



* code to create a dataset with averages
clear
set obs 9

* Creating the sector and group variables
gen sector = ""
gen group = ""
gen avg_exp = .

* Assigning sector names
replace sector = "Agriculture" if _n <= 3
replace sector = "Industry" if _n > 3 & _n <= 6
replace sector = "Services" if _n > 6 & _n <= 9

* Assigning group names
replace group = "All" if _n == 1 | _n == 4 | _n == 7
replace group = "Women" if _n == 2 | _n == 5 | _n == 8
replace group = "Men" if _n == 3 | _n == 6 | _n == 9

* Assuming these are the calculated averages, replacing them with actual values from your svy: mean outputs
replace avg_exp = 24.59861  in 1  // Agriculture - All
replace avg_exp =  18.96977  in 2  //  Agriculture - Women
replace avg_exp = 25.54156 in 3  //  Agriculture - Men
replace avg_exp =  17.39471 in 4  // Industry - All
replace avg_exp =  10.66335  in 5  // Industry - Women
replace avg_exp = 18.32829 in 6  // Industry - Men
replace avg_exp =  17.12402 in 7  // Services - All
replace avg_exp =  10.15757  in 8  // Services - Women
replace avg_exp = 18.7169 in 9 // Services - Men

save "average_experience.dta", replace

* Load the dataset with averages
use "average_experience.dta", clear

* Bar chart for Agriculture
graph bar avg_exp, over(group) title("Average Total Job Experience in Agriculture") name(Agriculture, replace)
graph export "8.png", replace
* Bar chart for Industry
graph bar avg_exp, over(group) title("Average Total Job Experience in Industry") name(Industry, replace)
graph export "9.png", replace
* Bar chart for Services
graph bar avg_exp, over(group) title("Average Total Job Experience in Services") name(Services, replace)
graph export "10.png", replace 




use "LFS1401Cleaned3.dta", clear
gen LessThan10Employer=0
replace LessThan10Employer=1 if NumofPeer==1 | NumofPeer==2

gen Between10and20Employer=0
replace Between10and20Employer=1 if NumofPeer==3

gen MoreThan20Employer=0
replace MoreThan20Employer=1 if NumofPeer==4 | NumofPeer==5

* Generate sector and firm size labels
generate sectorLabel = ""
replace sectorLabel = "Agriculture" if IsAgr == 1
replace sectorLabel = "Industry" if IsInd == 1
replace sectorLabel = "Services" if IsSrv == 1

generate firmSizeLabel = ""
replace firmSizeLabel = "Less than 10" if LessThan10Employer == 1
replace firmSizeLabel = "Between 10 and 20" if Between10and20Employer == 1
replace firmSizeLabel = "More than 20" if MoreThan20Employer == 1
* Example of creating readable label variables before collapsing
* This step assumes you've already generated sectorGroup and firmSize variables correctly
* Generate sector and firm size labels
collapse (sum) w, by(sectorLabel firmSizeLabel)
* Filter for Services and plot
keep if sectorLabel == "Services"
graph bar w, over(firmSizeLabel) ///
    ytitle("Number of Employers") ///
    title("Number of Employers by Firm Size in Services") ///
    ylabel(, format(%9.0g) labsize(small) angle(horizontal) grid) ///
    legend(label(1 "Less than 10") label(2 "Between 10 and 20") label(3 "More than 20"))
graph export "Services.png", replace




use "LFS1401Cleaned3.dta", clear


* Set the survey design for the dataset, specifying `w` as the weight variable
svyset _n [pw=w]

* Calculate the average of the last job experience of employers( not self-employed) for all individuals,men and women in each sector
foreach sector of varlist IsAgr IsInd IsSrv {
    * For the whole population
    svy: mean CurrJobExp if `sector' == 1 & selfemployed==0
    di "Average experience of employers in current job in sector (`sector'): " _b[CurrJobExp]
    
    * For women
    svy: mean CurrJobExp if `sector' == 1 & Sex == 0 & selfemployed==0
    di "Average experience of employers for women in current job in sector (`sector'): " _b[CurrJobExp]
    
    * For men
    svy: mean CurrJobExp if `sector' == 1 & Sex == 1 & selfemployed==0
    di "Average experience of employers for men in current job in sector (`sector'): "  _b[CurrJobExp]
}



* code to create a dataset with averages
clear
set obs 9

* Creating the sector and group variables
gen sector = ""
gen group = ""
gen avg_exp = .

* Assigning sector names
replace sector = "Agriculture" if _n <= 3
replace sector = "Industry" if _n > 3 & _n <= 6
replace sector = "Services" if _n > 6 & _n <= 9

* Assigning group names
replace group = "All" if _n == 1 | _n == 4 | _n == 7
replace group = "Women" if _n == 2 | _n == 5 | _n == 8
replace group = "Men" if _n == 3 | _n == 6 | _n == 9

* Assuming these are the calculated averages, replacing them with actual values from my svy: mean outputs
replace avg_exp = 10.26522    in 1  // Agriculture - All
replace avg_exp = 7.888463    in 2  //  Agriculture - Women
replace avg_exp = 10.45006 in 3  //  Agriculture - Men
replace avg_exp = 9.601501 in 4  // Industry - All
replace avg_exp = 5.282691  in 5  // Industry - Women
replace avg_exp = 9.987669 in 6  // Industry - Men
replace avg_exp = 9.443225 in 7  // Services - All
replace avg_exp = 8.943148 in 8  // Services - Women
replace avg_exp = 9.630521 in 9 // Services - Men

save "average_current_experience.dta", replace

* Load the dataset with averages
use "average_current_experience.dta", clear

* Bar chart for Agriculture
graph bar avg_exp, over(group) title("Average non-self-employers' Current Job Experience in Agriculture",size(3)) name(Agriculture, replace)
graph export "11.png", replace
* Bar chart for Industry
graph bar avg_exp, over(group) title("Average non-self-employers' Current Job Experience in Industry",size(3)) name(Industry, replace)
graph export "12.png", replace
* Bar chart for Services
graph bar avg_exp, over(group) title("Average non-self-employers' current Job Experience in Services",size(3)) name(Services, replace)
graph export "13.png", replace 

