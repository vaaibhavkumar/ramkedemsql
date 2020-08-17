--https://ramkedem.com/en/56-extracting-email-address/
; with index_identified as (SELECT textid, textcontent, charindex('@',textcontent)as index_of_attherate from ram.dbo.chat)
, leftpart as (SELECT textid, textcontent,index_of_attherate,  left(textcontent, index_of_attherate) as first_part from index_identified where index_of_attherate<>0) --select * from leftpart
, leftpart2 as (SELECT textid, textcontent,index_of_attherate,first_part, REVERSE(first_part) as reverse_first_part, REPLACE(textcontent,first_part,'') as right_part from leftpart )
, leftpart_laststep as(
	SELECT textid, textcontent,index_of_attherate,first_part, reverse_first_part,right_part
	, CHARINDEX(' ',reverse_first_part) as index_space_reverse_first_part
	, len(reverse_first_part) length_firstpart
	, case when CHARINDEX(' ',reverse_first_part) =0 then len(reverse_first_part)  else CHARINDEX(' ',reverse_first_part) end as index_start_email
	, case when CHARINDEX(' ',right_part) =0 then len(right_part)  else CHARINDEX(' ',right_part) end as index_domain_name
	,RIGHT(first_part, case when CHARINDEX(' ',reverse_first_part) =0 then len(reverse_first_part)  else CHARINDEX(' ',reverse_first_part) end) as body_emailaddress
	,LEFT(right_part,case when CHARINDEX(' ',right_part) =0 then len(right_part)  else CHARINDEX(' ',right_part) end ) as domain_name  
	from leftpart2
	)
select trim(concat(body_emailaddress, domain_name)) as email_address from leftpart_laststep 

