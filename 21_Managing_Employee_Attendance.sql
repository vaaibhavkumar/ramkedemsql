--https://ramkedem.com/en/managing-employee-attendance/
;With ClockedIN as	
(select EmpID, LogTime,try_cast(LogTime      as Date) As LoginDate, LogTime as ClockedIN from EmpTimeTracker where LogDetails = 'ClockedIN')

,ClockedOut as 
(select EmpID, LogTime,try_cast(LogTime      as Date) As LoginDate, LogTime as ClockedOut from EmpTimeTracker where LogDetails = 'ClockedOut')

SELECT c_in.EmpID, 
c_in.LoginDate,
c_in.ClockedIN, 
c_out.ClockedOut, 
try_cast(DATEDIFF(MI, c_in.ClockedIN,c_out.ClockedOut )/60.0 as numeric(5,2)) as 'Hours' 

FROM ClockedIN as c_in full 
outer join ClockedOut  as c_out on c_in.EmpID = c_out.EmpID and c_in.LoginDate = c_out.LoginDate 
order by EmpID,LoginDate
