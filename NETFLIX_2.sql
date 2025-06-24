-- LOAD DATA INFILE COMMAND

USE NETFLIX_DB;
SHOW TABLES;
DESC NETFLIX_DATASET;	

LOAD DATA INFILE 'C:\Users\Hemil\Desktop\sql\projNetF\netflix_titles_nov_2019.csv'
INTO TABLE NETFLIX_DATASET
FIELDS TERMINATED BY ','
optionally ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(show_id, title, director, cast, country, date_added, released_year, rating, duration, category_of_movies, description_of_movies, type_of_show);

-- corrected by chatGPT
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_titles_nov_2019.csv'
INTO TABLE NETFLIX_DATASET
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(show_id, title, director, cast, country, date_added, released_year, rating, duration, category_of_movies, description_of_movies, type_of_show);

-- TO SEE THE FOLDERS WHICH ARE SECURE TO TAKE DATA DIRECTLY FROM (by ChatGPT)
SHOW VARIABLES LIKE "secure_file_priv";

secure-file-priv="C:\\Users\\Hemil\\Desktop\\sql\\projNetF\\";

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 0;


SELECT * FROM NETFLIX_DATASET;