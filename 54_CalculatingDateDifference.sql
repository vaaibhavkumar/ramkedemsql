--54. Calculating Date Difference
--https://ramkedem.com/en/calculating-date-difference/
--the solution provided in the files of this git repo are my attempt. 
--for official solution to the question, please visit the official website  

--at least 6 months 
;with cte as (
SELECT t1.employeeid
, t1.employeename
, t1.HireDate as 'EmployeeHireDate'
, t1.ManagerId 
, t2.HireDate as 'ManagerHireDate'
,DATEDIFF(month,t2.HireDate ,t1.HireDate ) as diff_in_joiningmonth
, case when (DATEDIFF(month,t2.HireDate ,t1.HireDate )<=-6) then 1 else 0 end as validRecords
FROM q54_Employees as t1
left outer join  q54_Employees as t2 on t1.ManagerId = t2.employeeid )
SELECT employeename from cte where validRecords = 1 and EmployeeHireDate<managerhiredate
