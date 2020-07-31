--https://github.com/vaaibhavkumar/ramkedemsql/projects/1#card-42844080
--Fetching Rows by Groups
USE [ram]
GO
/****** Object:  StoredProcedure [dbo].[sp_fetching_rows_sections]    Script Date: 7/30/2020 5:29:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_fetching_rows_sections] As
begin 
--link http://ramkedem.com/en/sql-interview-question-fetching-rows-sections/
--Fetching Rows by Groups
with cte1 as (SELECT ProductId, ProductName, ProductPrice, ntile(3) over (order by ProductPrice asc) as PriceGroup FROM ram.dbo.Products)
, cte2 as (select ProductId, ProductName, ProductPrice, rank() over(Partition by PriceGroup order by ProductPrice asc) as Ranks FROM cte1) 
SELECT ProductId, ProductName, ProductPrice FROM cte2 where Ranks<=2

end

--EXEC sp_fetching_rows_sections
