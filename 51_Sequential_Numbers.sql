--https://ramkedem.com/en/51-sequential-numbers/

--link : https://ramkedem.com/en/51-sequential-numbers/
--1. make a continous series
--2. Compare the given series against it 
--3. Identify the missing models

-- defining the params for the series
Declare @Difference int = 1
Declare @StartingNumber int = 1
Declare @MaxNumber int = (SELECT max(modelid) from Bikes)

-- making the continous series
; WITH ContinousSeries AS (
SELECT 1 as Id
UNION ALL 
SELECT Id+1 FROM ContinousSeries
WHERE Id<@MaxNumber) --SELECT * FROM ContinousSeries

--Finding the missing ids  -- Approach 1 -- EXCEPT
SELECT Id from ContinousSeries
EXCEPT 
SELECT DISTINCT ModelId FROM Bikes

--Finding the missing ids  -- Approach 2	-- LEFT OUTER JOIN WHERE JOINING VALUE IS NULL 
SELECT CS.Id  from ContinousSeries as CS
left outer join Bikes as B on B.ModelID = CS.Id
WHERE B.ModelID is null -- this means the join failed here, hence they are the missing ones
