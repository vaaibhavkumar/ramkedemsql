--link https://ramkedem.com/en/comparing-grades/
--problem: Create a query to display all students who received a grade of 100 in Math and Physics.

--Approach 1:
SELECT s_id,s_name FROM [dbo].[studentGrades] WHERE s_prof = 'Math' AND s_grade = 100
INTERSECT 
SELECT s_id,s_name FROM [dbo].[studentGrades] WHERE s_prof = 'Science' AND s_grade = 100

--Approach 2:

SELECT t1.s_id,t2.s_name FROM [dbo].[studentGrades] AS t1 
JOIN [dbo].[studentGrades] AS t2 on t1.s_id = t2.s_id
WHERE t1.s_prof = 'Math' 
AND t1.s_grade = 100
AND t2.s_prof = 'Science' 
AND t2.s_grade = 100
