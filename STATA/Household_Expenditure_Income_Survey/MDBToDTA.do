clear
set more off
 


* Define the base paths
local baseCodePath "C:\Users\fatem\Downloads\Stata\HIES\Code"
local baseDataPath "C:\Users\fatem\Downloads\Stata\HIES\Data"

* Change directory
cd ${baseCodePath}

* Define the data segments and their areas
local segments "Data P1 P2 P3S01 P3S03"  // Assuming consistent segment naming across years
local areas "R U"  // Rural and Urban

* Define the years of interest
local years "98 99 1400 1401"

* Loop over each year
foreach year in `years` {
    * Loop over each area
    foreach area in `areas` {
        * Loop over each segment
        foreach segment in `segments` {
            * Construct table name and file name for saving
            local tableName = "`area``year``segment`"
            local fileName = "`baseDataPath`/"
            if "`area`" == "R" {
                local fileName = "`fileName`P`segment`_`year`_R.dta"
            }
            else {
                local fileName = "`fileName`P`segment`_`year`_U.dta"
            }
            
            * Query the database and load the table
			clear
            odbc query "HEIS`year`", dialog(complete)
            odbc desc "`tableName`"
            odbc load, table("`tableName`")
            
            * Save the loaded table to the specified location
            save "`fileName`", replace
        }
    }
}


 