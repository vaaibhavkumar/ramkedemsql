--https://ramkedem.com/en/products-by-type/
-- this is my personal attempt. for official solution to the question, please refer original website
-- Good question. 

SELECT * FROM 
(SELECT Row_Number() over (partition by GadgetType order by GadgetId) as rn, gadgetName, GadgetType from Gadgets) as basedata
pivot (max(gadgetName) for GadgetType  IN ([Spy Gadgets],[Smartwatches],[Gaming gadgets]) ) as p_data --max(string) 


--Failed attempt 2 
SELECT * FROM 
(SELECT Row_Number() over (partition by GadgetType order by GadgetId) as rn, gadgetName, GadgetType from Gadgets) as basedata
pivot (sum(rn) for GadgetType  IN ([Spy Gadgets],[Smartwatches],[Gaming gadgets]) ) as p_data


--Failed attempt 1
; with [Spy Gadgets] as (
	SELECT 	ROW_NUMBER() over (order by gadgetid) as rn
	,GadgetName as 'Spy Gadgets' from Gadgets where  GadgetType = 'Spy Gadgets' ) 
, SmartWatches AS (
	SELECT 	ROW_NUMBER() over (order by gadgetid) as rn
	,GadgetName as 'SmartWatches'  from Gadgets where  GadgetType = 'SmartWatches' )
, [Gaming Gadgets] AS (
	SELECT 	ROW_NUMBER() over (order by gadgetid) as rn
	,GadgetName as 'Gaming Gadgets' from Gadgets where  GadgetType = 'Gaming Gadgets') 
SELECT coalesce(sg.rn,sw.rn,gg.rn) as rn, sg.[Spy Gadgets], sw.SmartWatches, gg.[Gaming Gadgets] 
from [Spy Gadgets] as sg 
FULL OUTER JOIN SmartWatches as sw ON sg.rn = sw.rn 
FULL OUTER JOIN [Gaming Gadgets] as gg on gg.rn = sg.rn 
