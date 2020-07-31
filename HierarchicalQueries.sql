-- link https://ramkedem.com/en/job-interview-question-hierarchical-queries/
-- Task 1 First Task – Create a query to display the name of all employees, and the name of their manager.

SELECT	Emp.employee_id, 
		Emp.[First_Name], 
		Mgr.[First_Name] AS ManagerName 
FROM employees as Emp 
LEFT OUTER JOIN employees  AS Mgr ON Emp.[manager_id] = Mgr.employee_id

--Task 2 -- Second Task – Create a query to display the hierarchical relationship between a certain employee and his direct and indirect managers.
--For example, for employee number 7, the query will display the following result (Merlin reports to Jose, and Jose reports to Alvin)

DECLARE @employee_id int 
SET @employee_id = 10
;With Emp AS (
SELECT employee_id, First_Name, Manager_id as Manager_id, 0 As Officelevel FROM employees where employee_id = 10 --@employee_id -- IS NULL -- Base Query
UNION ALL 
SELECT manager.employee_id,manager.First_Name, manager.manager_id, Officelevel-1 AS Officelevel FROM employees AS manager
join Emp on manager.employee_id = Emp.manager_id -- This is the variable part 
) 
SELECT employee_id,First_Name, manager_id FROM Emp order by Officelevel desc
