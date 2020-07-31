--link https://ramkedem.com/en/sql-interview-question-conditional-count/
SELECT * FROM (
	SELECT [OrderDate]
      ,[CustomerTypeID]
	  , CASE 
			WHEN [CustomerTypeID] = 1 THEN 'Private' 
			WHEN [CustomerTypeID] = 2 THEN 'Business'
		END AS CustomerTypeDescription
      --,[ShipTypeId]
	  ,CASE 
			WHEN  [ShipTypeId] = 'L' THEN 'Domestic Shipping'
			WHEN  [ShipTypeId] = 'O' THEN 'International Shipping'
		END AS ShippingType
      ,SUM([Quantity]) AS Quantity
  FROM [ram].[dbo].[orders]
  group by [OrderDate]
      ,[CustomerTypeID]
      ,[ShipTypeId]
	  ) AS BaseData 
PIVOT (
SUM([Quantity]) 
FOR  ShippingType IN ([Domestic Shipping],[International Shipping])
) AS PivotData
