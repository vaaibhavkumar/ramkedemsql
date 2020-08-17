--19. Calculating a Cumulative Sum
--https://ramkedem.com/en/calculating-cumulative-sum/

--Approach 1
SELECT *, SUM(unitPrice) Over( order by ProductId) as CumulativeSum    
FROM Q19_Products_CumulativeSum 

--Approach 2
SELECT *, 
SUM(unitPrice) Over( order by ProductId ROWS Between unbounded preceding and 0 following  ) as CumulativeSum    
FROM Q19_Products_CumulativeSum 
--Approach 3
SELECT *, SUM(unitPrice) Over( order by ProductId ROWS Between unbounded preceding and 0 preceding  ) as CumulativeSum    
FROM Q19_Products_CumulativeSum 
