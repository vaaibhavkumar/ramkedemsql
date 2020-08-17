--https://ramkedem.com/en/10-low-high-values/
--this is my attempt. not official solution. 
-- for official solution, pls visit website. 
-- actually this question has been solved on mnay ways on the website

SELECT username, num_of_posts
FROM user_posts
WHERE num_of_posts IN ((SELECT MAX(num_of_posts) FROM user_posts),(SELECT MIN(num_of_posts) FROM user_posts))


