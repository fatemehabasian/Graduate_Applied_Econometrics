****************************************************************************Data Cleaning & Importing 



clear
cls
*use ".....\Data_cleanded.dta"
destring year GDP ABS ABD GCF EBGS CPIA1 CPIA2 CPIA3 MU5 CEDU FERT FINS IMAL PHE,replace force
format %17.0g  year GDP ABS ABD GCF EBGS CPIA1 CPIA2 CPIA3 MU5 CEDU FERT FINS IMAL PHE

 

*************************************************************************** Scatter plots of children under 5 Mortality vs ind. vars for all countries combined 
foreach x of varlist GDP ABS ABD CEDU FERT FINS IMAL PHE {
twoway (scatter MU5 `x'), ytitle(Infant Mortality) xtitle('`x'') saving(`x')
}
gr combine GDP.gph PHE.gph ABS.gph ABD.gph CEDU.gph FERT.gph FINS.gph IMAL.gph , ycommon
graph export ScatterMU5.png, replace


graph matrix GDP ABS ABD CEDU FERT FINS IMAL PHE , half note("Scatter Plot of Explanatory Variables")

graph export ALLVARSSCATTERPLOT.png, replace

 
*************************************************************************** panel definaning
encode country, generate(country_n)
drop country
xtset country_n year

 

***************************************************************************  part3 : ipolate_epolate
foreach x of varlist GDP-PHE{
ipolate `x' year , generate(`x'_ip) epolate by (country_n)
format %17.0g `x'_ip
drop `x'
rename `x'_ip `x'
}

*************************************************************************** label changing**********************************************************************************
label variable GDP "GDP per capita"

label variable ABS "Access to basic sanitation(% of population)"

label variable ABD "Access to basic drinking water "

label variable ABS "Access to basic sanitation "

label variable GCF "Gross capital formation"

label variable EBGS "External balance of goods and services"

label variable MU5 "Child Mortality "

label variable CEDU "Compulsory education"

label variable FERT "Fertility rate"

label variable FINS "Food insecuity"

label variable IMAL "Incidence of Malaria"

label variable PHE "Public health spending"








***************************************************************************  Summary Statistics and correlation of variables******************

eststo clear                                                                
estpost tabstat MU5 GDP PHE ABS ABD CEDU FERT FINS IMAL  , c(stat) stat(sum mean sd min max n)
esttab using "sumstat.tex", replace cells("sum(fmt(%13.0fc)) mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber nomtitle nonote noobs label collabels("Sum" "Mean" "SD" "Min" "Max" "N") b(2)
eststo clear  
estpost cor MU5 GDP PHE ABS ABD CEDU FERT FINS IMAL, matrix listwise
esttab using "cormatrix.tex", replace unstack nonote noobs compress label

***************************************************************************  plot for comparison*********************************************************************88

foreach x of varlist MU5 GDP PHE ABS ABD CEDU FERT FINS IMAL    {
xtline `x' , overlay ylabel(#20, labsize(6-pt) angle(horizontal)) xlabel(#15, labsize(6-pt))  
graph export plot_table2/`x'.png, replace 
} 

 


foreach x of varlist MU5 GDP PHE ABS ABD CEDU FERT FINS IMAL  {
bysort year : egen `x'_ave1 = mean(`x')
xtset country_n year
twoway scatter `x' year , msymbol(circle_hollow) || connected `x'_ave1 year, xlabel(#10, labsize(6-pt)) ylabel(#10, labsize(6-pt) angle(horizontal))  
graph export plot_table3/`x'_year.png, replace 
}

 

*********************************************************************Regression tables for infant mortality***********************************************************************

 
 ***part1 : normal variables
 
 ****************************************************************************Regressio models for child under 5 models




eststo clear
eststo: regress MU5 GDP 
eststo: regress MU5 GDP PHE  
eststo: regress MU5 GDP PHE ABS ABD
eststo: regress MU5 GDP PHE ABS ABD FERT FINS
eststo: regress MU5 GDP PHE ABS ABD FERT FINS IMAL CEDU

esttab using "normalregOLSMU5.tex", replace b(3) se(3) nonumbers title(" OLS (normal form)") mtitles("1" "2" "3" "4" "5") label


 

 



************************************************************************************log form variables
  
 
 
foreach x of varlist MU5 GDP PHE ABS ABD FERT FINS IMAL CEDU  {
generate double Ln_`x'= log(`x')
format %17.0g Ln_`x'
}

************************************************************************************Regression for Log form
 

*********************************************************************************label changing**********************************************************************************

label variable Ln_MU5 "Child Mortality"

label variable Ln_GDP "GDP per capita (log)"

label variable Ln_PHE "Public health spending (log)"

label variable Ln_ABS "Access to basec sanitation services"

label variable Ln_ABS "Access to basic sanitation services (log)"

label variable Ln_ABD "Access to basic drinking water (log)"

label variable Ln_FERT "Fertility rate (log)"

label variable Ln_FINS "Food Insecurity (log)"

label variable Ln_IMAL "Incidence of Malaria (log)"

label variable Ln_CEDU "Compulsory education (log)"



*************************************************************************************

eststo clear
eststo: regress Ln_MU5 Ln_GDP
eststo: regress Ln_MU5 Ln_GDP Ln_PHE  
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD Ln_FERT Ln_FINS
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU 
 

esttab using "logregOLSMU5.tex", replace b(3) se(3) nonumbers title("OLS (log fom)") mtitles("1" "2" "3" "4" "5") label


 
 
******************************************************************************************************************************************David macinson test for model specification
eststo clear
regress MU5 GDP PHE ABS ABD FERT FINS IMAL CEDU
predict double yhat, xb
format %17.0g yhat
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU  yhat

regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU 
predict double yhat2, xb
format %17.0g yhat2
eststo: regress MU5 GDP PHE ABS ABD FERT FINS IMAL CEDU yhat2

esttab using "DMtest.tex", replace b(3) se(3) nonumbers title("Davidson Mackinnon") label mtitle("B to A's predictor" " A to B's predictor")

**********************************************************************************************************************************************stationary testing


*****************stationary testing******************
***part1 : stationary test
foreach x of varlist  Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU {
asdoc  xtunitroot llc `x' , fs(9) save(plot_table1/tables.doc)
}
***part2 : defing the first order difference and stationary test
foreach x of varlist Ln_MU5 Ln_ABD{
generate double `x'1D= D.`x'
format %17.0g `x'1D
} 
 
 
***part3 : regression with stationary series

eststo clear
eststo: regress Ln_MU5 Ln_GDP
eststo: regress Ln_MU5 Ln_GDP Ln_PHE  
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU 
 

esttab using "DFREGRESSION.tex", replace b(3) se(3) nonumbers title("OLS model with first order diffrentiated variables") mtitles("1" "2" "3" "4" "5") label



 


 ************************************************************************************************************************************Variable inflation factor for perfect collinearity
 
regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU 
estat vif
asdoc estat vif, save(VIFtest.doc)



*****************Breush-Godfrey testing for serial correlation ******************
xtserial  Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU 


 
*****************omitted variable testing RESET******************
regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU 
estat ovtest
asdoc estat ovtest, save(RESETtest.doc)

*****************homoskedasticity testing for errors(residuals)******************
regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU 
predict residual2, resid

format %17.0g residual2
estat hettest (residual2)

hist residual2, normal
graph export histresid.png , replace


predict yhat3  
twoway (scatter residual2 yhat3), ytitle(residual) xtitle(yhat)  
graph export residual.png, replace





************************************************************************************************Robust Regression
eststo clear
eststo: regress Ln_MU5 Ln_GDP, robust
eststo: regress Ln_MU5 Ln_GDP Ln_PHE, robust
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D, robust
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS, robust
eststo: regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU, robust
 

esttab using "ROBUSTREGRESSION.tex", replace b(3) se(3) nonumbers title("Robust estimations") mtitles("1" "2" "3" "4" "5") label




********************************************************************************************year effect countrolled 


eststo clear
eststo: areg Ln_MU5 Ln_GDP, absorb(year)
eststo: areg Ln_MU5 Ln_GDP Ln_PHE, absorb(year)
eststo: areg Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D, absorb(year)
eststo: areg Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS, absorb(year)
eststo: areg Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU, absorb(year)

esttab using "ABSORBEDREGRESSION.tex", replace b(3) se(3) nonumbers title("OLS with controlled year effect") mtitles("1" "2" "3" "4" "5") stats(r2_a, label("Adjusted R-squared")) label


*******************************************************************************************significance tesiting



areg Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU , absorb(year)
test  Ln_GDP
test  Ln_PHE 
test  Ln_GDP Ln_PHE
test  Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU 

asdoc test  Ln_GDP, save(test.doc) replace
asdoc test  Ln_PHE, save(test.doc)
asdoc test  Ln_GDP Ln_PHE, save(test.doc)
asdoc test  Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU , save(test.doc)


 

***********************************************************************************************Instrumental variable analysis

ssc install reghdfe
net install ivreghdfe
ssc install ftools

gen CPIA = (CPIA1+CPIA2+CPIA3)/3

gen Log_CPIA=log(CPIA)
gen Log_GCF=log(GCF)
 
eststo clear

eststo: ivregress 2sls Ln_MU5 Ln_ABS i.year (Ln_GDP Ln_PHE = Log_CPIA EBGS Log_GCF) 
eststo: ivregress 2sls Ln_MU5 Ln_ABS Ln_ABD1D  i.year (Ln_GDP Ln_PHE = Log_CPIA EBGS Log_GCF) 
eststo: ivregress 2sls Ln_MU5 Ln_ABS Ln_ABD1D Ln_FERT i.year (Ln_GDP Ln_PHE = Log_CPIA EBGS Log_GCF) 
eststo: ivregress 2sls Ln_MU5 Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS i.year (Ln_GDP Ln_PHE = Log_CPIA EBGS Log_GCF) 
eststo: ivregress 2sls Ln_MU5 Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU i.year (Ln_GDP Ln_PHE = Log_CPIA EBGS Log_GCF) 


esttab using "IVreg.tex", nonumbers  title("IV estimation using 2SLS (absorbed year effect)" ) mtitle("1" "2" "3" "4" "5") drop(*.year) label replace 

****************************************************************************************************


eststo clear

eststo: ivregress 2sls Ln_MU5 Ln_ABS i.year (Ln_GDP Ln_PHE =  EBGS Log_GCF) 
eststo: ivregress 2sls Ln_MU5 Ln_ABS Ln_ABD1D  i.year (Ln_GDP Ln_PHE =  EBGS Log_GCF) 
eststo: ivregress 2sls Ln_MU5 Ln_ABS Ln_ABD1D Ln_FERT i.year (Ln_GDP Ln_PHE =   EBGS Log_GCF) 
eststo: ivregress 2sls Ln_MU5 Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS i.year (Ln_GDP Ln_PHE = EBGS Log_GCF) 
eststo: ivregress 2sls Ln_MU5 Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU i.year (Ln_GDP Ln_PHE = EBGS Log_GCF) 


esttab using "IVreg2.tex", nonumbers  title("IV estimation using 2SLS (absorbed year effect)" ) mtitle("1" "2" "3" "4" "5") drop(*.year) label replace 


**************************************************************************************************************hausman test

regress Ln_GDP Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU EBGS Log_GCF
predict residual6, resid 
regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU i.year residual6
test residual6
asdoc test residual6, save(test.doc)


regress Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU  EBGS Log_GCF
predict residual8, resid 
regress Ln_MU5 Ln_GDP Ln_PHE Ln_ABS Ln_ABD1D Ln_FERT Ln_FINS Ln_IMAL Ln_CEDU i.year residual8
test residual8
asdoc test residual8, save(test.doc)






















 









