--https://ramkedem.com/en/using-unpivot/


-- merge the cleaning, equipment and electricity headers
-- so basically we will create 2 new columns 
-- one will have the dimension -- we have to give that a name
-- one will have the measure -- we have to give that a name 

--Approach 1.1
SELECT * FROM (SELECT * FROM OfficeCosts) as basedata 
unpivot (Charged /*measure*/ FOR ChargeType /*name of dimension*/ in (Cleaning,Equipment, Electricity)) As unpvt
--Approach 1.2
SELECT * FROM OfficeCosts
unpivot (Charged /*measure*/ FOR ChargeType /*name of dimension*/ in (Cleaning,Equipment, Electricity)) As unpvt
