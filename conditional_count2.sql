-- link https://ramkedem.com/en/sql-interview-question-conditional-count/
-- another apporach https://github.com/vaaibhavkumar/ramkedemsql/blob/master/ConditionalCount.sql
-- Question: Will the answer be same if sum is done as  ,CASE WHEN  [ShipTypeId] = 'L' THEN SUM([Quantity]) END) AS 'Domestic Shipping'

	SELECT [OrderDate]
      ,[CustomerTypeID]
	  , CASE 
			WHEN [CustomerTypeID] = 1 THEN 'Private' 
			WHEN [CustomerTypeID] = 2 THEN 'Business'
		END AS CustomerTypeDescription
      --,[ShipTypeId]
	  ,SUM(CASE WHEN  [ShipTypeId] = 'L' THEN [Quantity] END) AS 'Domestic Shipping'
	  ,SUM(CASE WHEN  [ShipTypeId] = 'O' THEN [Quantity] END) AS 'International Shipping'
  FROM [ram].[dbo].[orders]
  group by [OrderDate]
      ,[CustomerTypeID]
     
     
     
      
