--link: https://ramkedem.com/en/identifying-groups/
--special: sub-queries, window function, CTE
--
with team_annual_score as (
SELECT 	team_id, 
		team_name,
		year(score_date) as score_year, 
		SUM(score_value) as score_value, 
		sum(special_award) As  special_award	
FROM Teams
group by 
		team_id, 
		team_name,
		year(score_date)
)
, max_awarded_team as (
SELECT team_id,team_name, rank() over(order by special_award desc) as ranks 
FROM team_annual_score
-- also 
-- select top 1 team_id, team_name,sum(special_award) as count_special_award  from Teams group by team_id, team_name order by count_special_award   desc
)
SELECT 
	t1.team_name,
	t1.score_year,
	t1.score_value 
from team_annual_score  as t1
WHERE t1.team_id IN ( SELECT team_id FROM max_awarded_team WHERE ranks=1)
