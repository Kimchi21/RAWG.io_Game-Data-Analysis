USE rawg;

SELECT *
  FROM rawg.games;

SELECT COUNT(name) AS number_of_games
  FROM rawg.games;

-- General game info
-- 1.) What are the top 10 oldest and newest games?
-- Oldest
SELECT name, 
       released
  FROM rawg.games
 WHERE released IS NOT NULL
 ORDER BY released ASC
 LIMIT 10;
 
-- Newest
-- This does not account for future releases and the latest date limit was set to when the data was pulled
SELECT name, 
       released
  FROM rawg.games
 WHERE released IS NOT NULL AND released < "2023-12-20"
 ORDER BY released DESC
 LIMIT 10;
 
 -- 2.) What are the top 10 games which have the highest average playtime?
 -- Note: The playtime recorded is already the average result
SELECT name, 
       playtime
  FROM rawg.games
 ORDER BY playtime DESC
 LIMIT 10;
 
-- 3.) What are the top 10 highest and lowest rated games according to metacritic rating?
-- Highest Rated
SELECT name, 
       metacritic
  FROM rawg.games
 WHERE metacritic IS NOT NULL
 ORDER BY metacritic DESC
 LIMIT 10;
 
-- Lowest Rated
SELECT name, 
       metacritic
  FROM rawg.games
 WHERE metacritic IS NOT NULL
 ORDER BY metacritic ASC
 LIMIT 10;
 
 -- ESRB rating
 -- 4.) What is the distribution of esrb rating given to the games?
SELECT er.name AS esrb_rating,
	   COUNT(er.name) AS rating_count
  FROM rawg.games AS g
	   INNER JOIN esrb_rating_category AS erc
	   ON erc.game_id = g.game_id
	   INNER JOIN esrb_rating AS er
	   ON er.esrb_rating_id = erc.esrb_rating_id
 GROUP BY er.name;
 
-- Game rating
-- 5.) What are the top 10 games which have the highest rating?
-- A set number of reviews must be set because the average of ratings will be skewed depending on the number of reviews as well as the rating score given.
-- Simple solution is to take half of the game with the highest review count and set it as the parameter. #3375
SELECT (MAX(reviews_count) / 2) AS param
  FROM ratings;

SELECT g.name,
	   r.rating
  FROM rawg.games AS g
	   INNER JOIN ratings AS r
	   ON r.game_id = g.game_id
	   INNER JOIN ratings_score AS rs
	   ON rs.rating_id = r.rating_id
 WHERE r.reviews_count >= 3375
 ORDER BY r.rating DESC
 LIMIT 10;

-- 6.) What are the top 10 games which have the review count rating?
-- Note: review count is used because it is sum of all scores given via the rating scores of exceptional, recommended, meh, skip on the ratings_score table
SELECT g.name,
	   r.reviews_count
  FROM rawg.games AS g
	   INNER JOIN ratings AS r
	   ON r.game_id = g.game_id
	   INNER JOIN ratings_score AS rs
	   ON rs.rating_id = r.rating_id
 ORDER BY r.reviews_count DESC
 LIMIT 10;

-- rating score
-- 7a.) What are the top 10 games with highest exceptional rating score obtained?
SELECT g.name,
	   rs.exceptional
  FROM rawg.games AS g
	   INNER JOIN ratings AS r
	   ON r.game_id = g.game_id
	   INNER JOIN ratings_score AS rs
	   ON rs.rating_id = r.rating_id
 ORDER BY rs.exceptional DESC
 LIMIT 10;
 
-- 7b.) What are the top 10 games with highest recommended rating score obtained?
SELECT g.name,
	   rs.recommended
  FROM rawg.games AS g
	   INNER JOIN ratings AS r
	   ON r.game_id = g.game_id
	   INNER JOIN ratings_score AS rs
	   ON rs.rating_id = r.rating_id
 ORDER BY rs.recommended DESC
 LIMIT 10;
 
-- 7c.) What are the top 10 games with highest meh rating score obtained?
SELECT g.name,
	   rs.meh
  FROM rawg.games AS g
	   INNER JOIN ratings AS r
	   ON r.game_id = g.game_id
	   INNER JOIN ratings_score AS rs
	   ON rs.rating_id = r.rating_id
 ORDER BY rs.meh DESC
 LIMIT 10;
 
 -- 7d.) What are the top 10 games with highest skip rating score obtained?
SELECT g.name,
	   rs.skip
  FROM rawg.games AS g
	   INNER JOIN ratings AS r
	   ON r.game_id = g.game_id
	   INNER JOIN ratings_score AS rs
	   ON rs.rating_id = r.rating_id
 ORDER BY rs.skip DESC
 LIMIT 10;
 
-- Library info
-- 8.) What are the top 10 games which were added the most to players libray?
SELECT g.name,
	   l.added
  FROM rawg.games AS g
	   INNER JOIN library AS l
	   ON l.game_id = g.game_id
	   INNER JOIN library_status AS ls
	   ON ls.library_id = l.library_id
 ORDER BY l.added DESC
 LIMIT 10;
 
-- library status / status of added
-- 9a.) What are the top 10 games with the most number of dropped status?
SELECT g.name,
	   ls.dropped
  FROM rawg.games AS g
	   INNER JOIN library AS l
	   ON l.game_id = g.game_id
	   INNER JOIN library_status AS ls
	   ON ls.library_id = l.library_id
 ORDER BY ls.dropped DESC
 LIMIT 10;
 
-- 9b.) What are the top 10 games with the most number of yet status?
SELECT g.name,
	   ls.yet
  FROM rawg.games AS g
	   INNER JOIN library AS l
	   ON l.game_id = g.game_id
	   INNER JOIN library_status AS ls
	   ON ls.library_id = l.library_id
 ORDER BY ls.yet DESC
 LIMIT 10;

-- 9c.) What are the top 10 games with the most number of owned status?
SELECT g.name,
	   ls.owned
  FROM rawg.games AS g
	   INNER JOIN library AS l
	   ON l.game_id = g.game_id
	   INNER JOIN library_status AS ls
	   ON ls.library_id = l.library_id
 ORDER BY ls.owned DESC
 LIMIT 10;
 
-- 9d.) What are the top 10 games with the most number of beaten status?
SELECT g.name,
	   ls.beaten
  FROM rawg.games AS g
	   INNER JOIN library AS l
	   ON l.game_id = g.game_id
	   INNER JOIN library_status AS ls
	   ON ls.library_id = l.library_id
 ORDER BY ls.beaten DESC
 LIMIT 10;
 
-- 9e.) What are the top 10 games with the most number of toplay status?
SELECT g.name,
	   ls.toplay
  FROM rawg.games AS g
	   INNER JOIN library AS l
	   ON l.game_id = g.game_id
	   INNER JOIN library_status AS ls
	   ON ls.library_id = l.library_id
 ORDER BY ls.toplay DESC
 LIMIT 10;
 
-- 9f.) What are the top 10 games with the most number of playing status?
SELECT g.name,
	   ls.playing
  FROM rawg.games AS g
	   INNER JOIN library AS l
	   ON l.game_id = g.game_id
	   INNER JOIN library_status AS ls
	   ON ls.library_id = l.library_id
 ORDER BY ls.playing DESC
 LIMIT 10;

-- Platform info
-- 10.) What is the distribution of general platforms?
-- Since the values are stored in one record it needs to be seperated by coma and get the value to be counted.
-- Create a temporary table to hold the split values
CREATE TEMPORARY TABLE temp_split_values (
    value VARCHAR(128)
);

-- ad-hoc table gen
INSERT INTO temp_split_values
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(name, ', ', numbers.n), ', ', -1) AS value
FROM (
    -- Generating numbers from 0 to 99 using a numbers table
    SELECT (a.N + b.N * 10 + 1) AS n
    FROM
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
        CROSS JOIN
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
) AS numbers
JOIN parent_platform ON CHAR_LENGTH(name) - CHAR_LENGTH(REPLACE(name, ', ', '')) >= numbers.n - 1;

-- Now count based on the values of the temp table
SELECT value AS general_platform, COUNT(*) AS count
  FROM temp_split_values
 GROUP BY value
 ORDER BY count DESC;
 
DROP TEMPORARY TABLE IF EXISTS temp_split_values;

-- 11.) What is the distribution of specific platforms?
CREATE TEMPORARY TABLE temp_split_values (
    value VARCHAR(255)
);

INSERT INTO temp_split_values
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(name, ', ', numbers.n), ', ', -1) AS value
FROM (
    -- Generating numbers from 0 to 99 using a numbers table
    SELECT (a.N + b.N * 10 + 1) AS n
    FROM
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
        CROSS JOIN
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
) AS numbers
JOIN platform_details ON CHAR_LENGTH(name) - CHAR_LENGTH(REPLACE(name, ', ', '')) >= numbers.n - 1;

SELECT value AS specific_platform, COUNT(*) AS count
  FROM temp_split_values
 GROUP BY value
 ORDER BY count DESC;
 
DROP TEMPORARY TABLE IF EXISTS temp_split_values;

-- Stores info
-- 12.) What is the distribution of specific stores?
CREATE TEMPORARY TABLE temp_split_values (
    value VARCHAR(128)
);

INSERT INTO temp_split_values
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(name, ', ', numbers.n), ', ', -1) AS value
FROM (
    -- Generating numbers from 0 to 99 using a numbers table
    SELECT (a.N + b.N * 10 + 1) AS n
    FROM
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
        CROSS JOIN
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
) AS numbers
JOIN store_details ON CHAR_LENGTH(name) - CHAR_LENGTH(REPLACE(name, ', ', '')) >= numbers.n - 1;

SELECT value AS store, COUNT(*) AS count
  FROM temp_split_values
 GROUP BY value
 ORDER BY count DESC;
 
DROP TEMPORARY TABLE IF EXISTS temp_split_values;

-- Genres info
-- 13.) What is the distribution of genres?
CREATE TEMPORARY TABLE temp_split_values (
    value VARCHAR(255)
);

INSERT INTO temp_split_values
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(genre_name, ', ', numbers.n), ', ', -1) AS value
FROM (
    -- Generating numbers from 0 to 99 using a numbers table
    SELECT (a.N + b.N * 10 + 1) AS n
    FROM
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
        CROSS JOIN
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
) AS numbers
JOIN genres ON CHAR_LENGTH(genre_name) - CHAR_LENGTH(REPLACE(genre_name, ', ', '')) >= numbers.n - 1;

SELECT value AS genre, COUNT(*) AS count
  FROM temp_split_values
 GROUP BY value
 ORDER BY count DESC;
 
DROP TEMPORARY TABLE IF EXISTS temp_split_values;

-- Tags info
-- 14.) What is the distribution of tags?
-- If timeout persists
SET SESSION wait_timeout = 600;

CREATE TEMPORARY TABLE temp_split_values (
    value VARCHAR(1024)
);

INSERT INTO temp_split_values
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(tag_name, ', ', numbers.n), ', ', -1) AS value
FROM (
    -- Generating numbers from 0 to 99 using a numbers table
    SELECT (a.N + b.N * 10 + 1) AS n
    FROM
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
        CROSS JOIN
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
) AS numbers
JOIN tags ON CHAR_LENGTH(tag_name) - CHAR_LENGTH(REPLACE(tag_name, ', ', '')) >= numbers.n - 1;

SELECT value AS tags, COUNT(*) AS count
  FROM temp_split_values
 GROUP BY value
 ORDER BY count DESC;
 
DROP TEMPORARY TABLE IF EXISTS temp_split_values;

-- Developers info
-- 15.) What is the distribution of developers?
CREATE TEMPORARY TABLE temp_split_values (
    value VARCHAR(1250)
);

INSERT INTO temp_split_values
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(developer_name, ', ', numbers.n), ', ', -1) AS value
FROM (
    -- Generating numbers from 0 to 99 using a numbers table
    SELECT (a.N + b.N * 10 + 1) AS n
    FROM
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
        CROSS JOIN
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
) AS numbers
JOIN developers ON CHAR_LENGTH(developer_name) - CHAR_LENGTH(REPLACE(developer_name, ', ', '')) >= numbers.n - 1;

SELECT value AS developers, COUNT(*) AS count
  FROM temp_split_values
 GROUP BY value
 ORDER BY count DESC;
 
DROP TEMPORARY TABLE IF EXISTS temp_split_values;

-- Publishers info
-- 16.) What is the distribution of developers?
CREATE TEMPORARY TABLE temp_split_values (
    value VARCHAR(512)
);

INSERT INTO temp_split_values
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(publisher_name, ', ', numbers.n), ', ', -1) AS value
FROM (
    -- Generating numbers from 0 to 99 using a numbers table
    SELECT (a.N + b.N * 10 + 1) AS n
    FROM
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
        CROSS JOIN
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
) AS numbers
JOIN publishers ON CHAR_LENGTH(publisher_name) - CHAR_LENGTH(REPLACE(publisher_name, ', ', '')) >= numbers.n - 1;

SELECT value AS publishers, COUNT(*) AS count
  FROM temp_split_values
 GROUP BY value
 ORDER BY count DESC;
 
DROP TEMPORARY TABLE IF EXISTS temp_split_values;