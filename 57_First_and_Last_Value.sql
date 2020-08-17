--https://ramkedem.com/en/first-last-value/
-- Approach 1 
;with cte1 as (SELECT DestDate, CurrDest, CONCAT(DATEPART(YEAR,DestDate),'-', DATEPART(month,DestDate)) as Year_Month from destinations)
,cte2 as (
	SELECT	DestDate
			, CurrDest
			, Year_Month
			--, MIN(DestDate) OVER(PARTITION BY  Year_Month ORDER BY DestDate ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as FirstDestDate
			--, MAX(DestDate) OVER(PARTITION BY  Year_Month ORDER BY DestDate ASC  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as LastDestDate
			, row_number() over(partition by Year_Month ORDER BY DestDate ASC) as row_num  
	FROM cte1 )
-- Get the first destination for each month
,cte3 as (SELECT Year_Month, CurrDest  FROM cte2 where row_num = 1) 

-- Get the last destination for each month
,cte4 as (SELECT t_out.Year_Month, t_out.CurrDest  FROM cte2 as t_out where row_num = (SELECT MAX(row_num) FROM cte2 WHERE t_out.Year_Month = cte2.Year_Month))

-- Get the desired output 
SELECT cte3.Year_Month as Months, cte3.CurrDest as 'First Dest', cte4.CurrDest as 'Last Dest' FROM cte4 JOIN cte3 on cte3.Year_Month = cte4.Year_Month
