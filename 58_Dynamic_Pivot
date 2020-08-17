--https://ramkedem.com/en/dynamic-pivot/
DECLARE @DynamicQuery nvarchar(max)
DECLARE @DepartmentList nvarchar(max)
;with dept_names as (SELECT DISTINCT trim(department) as department FROM dynamicpivot_q58_sales)
SELECT @DepartmentList = (SELECT string_agg(quotename(department),',') FROM dept_names)
SELECT @DepartmentList 
SET @DynamicQuery = 'SELECT * FROM (SELECT saleDate, department, amount FROM dynamicpivot_q58_sales  ) as base_data pivot(sum(amount) for department in ('+@DepartmentList+')) as pivot_data'
exec (@DynamicQuery )

