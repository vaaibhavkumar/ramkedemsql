/*
link : https://ramkedem.com/en/travel-destinations/
basically : 
1. full outer join. How to do it? How to handle nulls from 2 both tables
2. in full outer join, we expect nulls to come from both side of tables so for the common fields in select, we need to have isnull() or the coalesce function
3. difference between isnull and coalesce is: coalesce can have multiple values 
and it always returns the first not null value 

some cool examples are present here 
https://www.sqlshack.com/using-the-sql-coalesce-function-in-sql-server/#:~:text=The%20SQL%20Coalesce%20and%20IsNull,from%20the%20defined%20argument%20list.

we can do some aggregation using  STRING_AGG  and coalesce function (but this one is tough) 

*/

with cte_domestic_travel_details as (
SELECT 
	p.person_id, 
	person_name, 
	loc_i.[location], 
	rank() over (partition by p.person_id order by loc_i.[location] asc) as ranks 
	from [dbo].[persons] as p  
	join [dbo].[locations_israel] as loc_i on p.[person_id] = loc_i.person_id
)
-- when we create multiple cte they are separated simply by , 
-- there is no need to prefix wih ... 
-- there is no need to use the just declared cte in the next cte 
, cte_aborad_travel_details as (
SELECT 
	p.person_id, 
	person_name, 
	loc_a.[location], 
	rank() over (partition by p.person_id order by loc_a.[location] asc) as ranks 
	from [dbo].[persons] as p  
	join [dbo].[locations_abroad] as loc_a on p.[person_id] = loc_a.person_id
)

SELECT coalesce(d.person_name, a.person_name) as person_name, d.[location] as location_israel, a.location as location_abroad 
FROM cte_domestic_travel_details as d 
FULL OUTER JOIN  cte_aborad_travel_details as a
on a.person_id = d.person_id
AND a.ranks = d.ranks
order by person_name
