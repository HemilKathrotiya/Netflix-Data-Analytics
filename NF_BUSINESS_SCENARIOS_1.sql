-- 1. Count the number of tv shows vs movies
SELECT TYPE, -- COMMA REQUIRES
	COUNT(*) AS COUNT_CONTENT -- alias optional	 
FROM NETFLIX_DATASET
GROUP BY TYPE;

-- 2. Find the top Five country with most content on netflix	
SELECT COUNTRY , COUNT(*) AS CONTENT_COUNT
FROM NETFLIX_DATASET
GROUP BY COUNTRY 
ORDER BY CONTENT_COUNT DESC 
LIMIT 5;

-- 3. List All Movies that are Documentaries 
SELECT TITLE FROM NETFLIX_DATASET
WHERE TYPE LIKE 'Movie%' AND
LISTED_IN LIKE '%Documentaries%';

SELECT COUNT(TITLE) AS TOTAL_DOCUMENTARIES FROM NETFLIX_DATASET -- COUNT
WHERE TYPE LIKE 'Movie%' AND LISTED_IN LIKE '%Documentaries%';

-- 4. Identify the longest Movie
SELECT CAST(REPLACE(DURATION,'MIN', '')AS unsigned) AS Minutes 
FROM NETFLIX_DATASET WHERE TYPE LIKE 'MOVIE%'
ORDER BY CAST(REPLACE(DURATION,'MIN', '')AS unsigned) DESC ;

SELECT TITLE, DURATION, TYPE AS Minutes -- TYPE
FROM NETFLIX_DATASET WHERE TYPE LIKE 'MOVIE%'
ORDER BY CAST(REPLACE(DURATION,'MIN', '')AS unsigned) DESC LIMIT 1;

-- 5.Count the Number of Content Items in Each Genre
SELECT LISTED_IN, COUNT(*) AS TT
FROM NETFLIX_DATASET
GROUP BY 1
ORDER BY TT DESC;

-- 6. List All Movies Released in a specific year (e.g.2018)
SELECT TITLE FROM NETFLIX_DATASET 
WHERE TYPE LIKE 'Movie%' AND RELEASED_YEAR = 2015;

-- 7. Find the content added in last 5/6/7/... years

SELECT CURDATE(); -- GIVES TODAYS i.e. CURRENT DATE IN YYYY-MM-DD FORMATE
SELECT YEAR(CURDATE()); SELECT MONTH(CURDATE()); SELECT DAY(CURDATE()); -- EACH FOR SPECIFIC INDIVIDUAL YYYY/ MM/ DD

SELECT TITLE , YEAR(STR_TO_DATE(DATE_ADDED, '%M %d %Y')) as year
FROM NETFLIX_DATASET																-- works till here
WHERE YEAR(CURDATE()) - YEAR(STR_TO_DATE( DATE_ADDED, '%M %d, %Y')) <= 6	 ; -- but not here

select YEAR(CURDATE()) - YEAR(STR_TO_DATE( DATE_ADDED, '%M %D, %Y'))  <= 7 from netflix_dataset; -- \

-- 8. Find all movies and tv showes directed by rajiv chiraka

SELECT * FROM NETFLIX_DATASET
WHERE DIRECTOR = '%Rajiv Chiraka%'; -- NOT WORKING??

-- 9. List all TV shows with more than 5 seasons
SELECT TITLE, DURATION
FROM NETFLIX_DATASET
WHERE TYPE LIKE '%TV SHOW%' AND CAST(REPLACE(DURATION, ' SEASON','') AS UNSIGNED) >5; 

CAST(REPLACE(DURATION, ' SEASON','') AS UNSIGNED);-- USED TO CONVERT STR TO INT i.e. UNSIGNED

-- 10. Find all the content without a Director
SELECT TITLE,DIRECTOR FROM NETFLIX_DATASET WHERE DIRECTOR IS NULL OR DIRECTOR='';

-- 11. Find how many movies actor 'Salman Khan' released in last 10/15/20/... years
SELECT TITLE, RELEASED_YEAR -- COUNT(*), AS MOVIES_COUNT
FROM NETFLIX_DATASET
WHERE TYPE LIKE 'MOVIE%' AND CAST LIKE '%Salman Khan%'
AND RELEASED_YEAR >= YEAR(CURDATE()) - 20;

-- 12. IDENTFY movie/tv shows featuring a specific actor (e.g. "Robert de Niro")
SELECT * FROM NETFLIX_DATASET
WHERE CAST LIKE '%Robert De niro%';

-- 13. Group the recoed by year and count the number of movies/tv showes added each year 
SELECT RELEASED_YEAR, COUNT(*) AS TOTAL_RELEASE
FROM NETFLIX_DATASET
GROUP BY RELEASED_YEAR ORDER BY RELEASED_YEAR DESC;

-- 14. Find Each Year and the Average Numbers of Content released in India on Netflix
SELECT RELEASED_YEAR, AVG(TOTAL) FROM
(SELECT RELEASED_YEAR, COUNT(*) AS TOTAL
FROM NETFLIX_DATASET
WHERE COUNTRY = 'INDIA'
GROUP BY RELEASED_YEAR 
ORDER BY RELEASED_YEAR DESC) AS YEAR_DATA
GROUP BY RELEASED_YEAR;

-- 15. Identfy the top 3 most common geners in the dataset
SELECT LISTED_IN, count(*) AS TOTAL
FROM NETFLIX_DATASET
GROUP BY 1
ORDER BY 2 DESC LIMIT 3;

-- 16. Identfy the most Active month for adding movies/tv shows (by count)
-- very bad way to write query🤷‍♀️🤷‍♀️ 
SELECT * FROM
(SELECT MONTH(str_to_date(DATE_ADDED, '%M %d, %Y')) AS MONTH, COUNT(*) AS TOTAL_ADDED
FROM NETFLIX_DATASET GROUP BY 1
ORDER BY 2 DESC) AS RESULT_DATA
WHERE MONTH IS NOT NULL LIMIT 1;

-- 17. {IMP IMP} Compare the Number of Movies and TV shows added Before and After 2015
SELECT
	CASE WHEN RELEASED_YEAR < 2015 THEN 'BEFORE 2015' ELSE 'AFTER 2015' END AS PERIOD,
    TYPE, COUNT(*) AS TOTAL
FROM NETFLIX_DATASET
GROUP BY 1,2;

-- 18. Retrieve All Movies/TV shows that were added in the last 6 months
SELECT * FROM NETFLIX_DATASET
WHERE STR_TO_DATE(DATE_ADDED, '%M %d, %Y') >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

SELECT DATE_SUB(CURDATE(), INTERVAL 6 MONTH); -- DISPLAYS DATE FROM 6 MONTH PRIOR TO TODAY'S DATE

-- 19. Find the Average Duration of Movies (in Minutes)

SELECT AVG(CAST(REPLACE(DURATION, 'min', '') AS UNSIGNED)) AS AVERAGE_DURATION FROM NETFLIX_DATASET
WHERE TYPE LIKE '%MOVIE%';

-- 20.Find the TOP 10 actors who have appeared in the highest number of movies produced in India (HOME WORK)


-- 21.Categorised Content Based on the presence of 'kill' and 'violance' Keyword (home work)

SELECT * FROM NETFLIX_DATASET;