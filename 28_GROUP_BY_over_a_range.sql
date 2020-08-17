--28. GROUP BY over a range
--https://ramkedem.com/en/fibonacci-sequence/
--This is a tricky question at least for me 

WITH cte_Fibonacci  AS
(
SELECT 0 AS FirstNumber, 1 AS SecondNumber
UNION ALL
SELECT SecondNumber AS FirstNumber, FirstNumber+ SecondNumber AS SecondNumber FROM cte_Fibonacci
)
SELECT TOP 20 * FROM cte_Fibonacci


-- failed attempt -- actuualy answer gets displayed along with an error message :( 
WITH cte_Fibonacci  AS
(
SELECT 0 AS FirstNumber, 1 AS SecondNumber,  try_cast(1 as bigint) as counters
UNION ALL
SELECT SecondNumber AS FirstNumber, FirstNumber+ SecondNumber AS SecondNumber,counters+1 as counters  FROM cte_Fibonacci
)
SELECT FirstNumber FROM cte_Fibonacci where counters<=20


