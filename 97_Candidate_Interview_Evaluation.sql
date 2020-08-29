--link: https://ramkedem.com/en/candidate-interview-evaluation/
--important point: aggregate on top of a case  statement
--string concatenation 
WITH cte_candidate_subjectwise_score as (
SELECT	c.c_id
		,c.c_name 
		,isnull(e.e_type, '') as e_type 
		,case when e.e_score is not null then trim(lower(e.e_score)) else null end as e_score  -- case handling
FROM [dbo].[candidates] as c 
left join [dbo].[evaluations] as e on c.c_id = e.c_id -- there is a chance that all candidates may not have been evaluated, hence this can be kept as a left join 
)
,cte_candidate_aggregated_score as (
SELECT sws.c_name,  
	sum(case when sws.e_score  ='pass' then 0 --sws.e_score.trim().lower() 
	when sws.e_score   ='failed' then -1 --sws.e_score.trim().lower() 
	when sws.e_score is null then null
end) as final_score 
FROM cte_candidate_subjectwise_score As sws
group by sws.c_name
) 

select c_name, 
case when final_score = 0 then 'Passed'
when final_score = -1 then 'Failed in 1 evaluation'
when final_score = -2 then 'Failed in 2 evaluations'
when final_score <=-3 then 'Failed'
when final_score is null then 'Pending'
end as final_score
FROM 
cte_candidate_aggregated_score
