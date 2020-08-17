--question : https://ramkedem.com/en/rollup-cube/
--Approach 1 
SELECT concat(DATEPART(Year, sr_date),'-', DATEPART(Quarter, sr_date)) as SalesQuarter, /*sr_date,*/ sr_department, sum(sr_amount) as sr_amount FROM store_revenues
group by sr_date, sr_department
with rollup 

--Approach 2
SELECT concat(DATEPART(Year, sr_date),'-', DATEPART(Quarter, sr_date)) as SalesQuarter, /*sr_date,*/ sr_department, sum(sr_amount) as sr_amount FROM store_revenues
group by sr_date, sr_department 
with cube 

/*

**https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql?view=sql-server-ver15**
**GROUP BY ROLLUP**
Creates a group for each combination of column expressions. In addition, it "rolls up" the results into subtotals and grand totals. To do this, it moves from right to left decreasing the number of column expressions over which it creates groups and the aggregation(s).

The column order affects the ROLLUP output and can affect the number of rows in the result set.

For example, GROUP BY ROLLUP (col1, col2, col3, col4) creates groups for each combination of column expressions in the following lists.
col1, col2, col3, col4
col1, col2, col3, NULL
col1, col2, NULL, NULL
col1, NULL, NULL, NULL
NULL, NULL, NULL, NULL --This is the grand total

SELECT Country, Region, SUM(Sales) AS TotalSales
FROM Sales
GROUP BY ROLLUP (Country, Region);

Country	      Region	          TotalSales  
Canada	      Alberta	          100 
Canada	      British Columbia	500
Canada	      NULL	            600
United States	Montana	          100
United States	NULL	            100
NULL	        NULL	            700
-------------===========================
SELECT Country, Region, SUM(Sales) AS TotalSales
FROM Sales
GROUP BY CUBE (Country, Region);

The query result has groups for unique values of (Country, Region), (NULL, Region), (Country, NULL), and (NULL, NULL). The results look like this:
GROUP BY CUBE ( )

Country			      Region				    TotalSales
Canada			      Alberta				    100
NULL			        Alberta				    100   --> additional record
Canada			      British Columbia	500
NULL			        British Columbia	500   --> additional record
United States	    Montana				    100
NULL			        Montana				    100   --> additional record

NULL			        NULL				      700   --> COMMON WITH ROLLUP 
Canada			      NULL				      600   --> COMMON WITH ROLLUP
United States	    NULL				      100   --> COMMON WITH ROLLUP

*/
