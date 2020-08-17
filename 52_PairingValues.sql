--https://ramkedem.com/en/pairing-values/

;with cte1 as(
SELECT 
	memberid, 
	membername as FirstMemberName, 
	memberage 
	,(SELECT t_in.membername from Family as t_in where t_in.memberage = (SELECT MIN(memberage) from Family where memberage> t_out.memberage)) as NextMemberName
	, row_number() over(order by memberage) as row_num
FROM Family as t_out)
SELECT FirstMemberName, NextMemberName from cte1 WHERE row_num%2=1

-- this is my attempt. 
-- note for self: the official solution to this question is great. Revise it


-- link: https://ramkedem.com/en/pairing-values/
--make pairs of 2 closest to each other based on age 
-- possible variations, the group size can be 2, 3, 4 etc. 
-- possible variations, pair the youngest with the oldest 
-- possible variation, decide the best size of pair (like for 9 propose pairs of 3, for 16 pairs of 4 etc and then make pairs as per the conditions: closest in age, fartheset in age etc. 

--Approach1: sort family members by age, rank them , keep all odds in 1 column, keep all evens in other column
; with cte_order_by_age as (SELECT *, ROW_NUMBER() over(order by memberage) as order_by_age FROM family  )
, MemberName1 as (SELECT MemberName , Order_by_age from cte_order_by_age where Order_by_age%2=1)
, MemberName2 as (SELECT MemberName , Order_by_age from cte_order_by_age where Order_by_age%2=0)
SELECT t1.MemberName As MemberName1, t2.MemberName AS MemberName2 from MemberName1 as t1
left outer join MemberName2 as t2 on t1.order_by_age+1 = t2.order_by_age
