USE rawg;

-- only using * because of testing purposes

SELECT *
	FROM rawg.games;

-- esrb test
SELECT *
  FROM rawg.games AS g
	   INNER JOIN esrb_rating_category AS erc
	   ON erc.game_id = g.game_id
	   INNER JOIN esrb_rating AS er
	   ON er.esrb_rating_id = erc.esrb_rating_id;

-- ratings test
SELECT *
  FROM rawg.games AS g
	   INNER JOIN ratings AS r
	   ON r.game_id = g.game_id
	   INNER JOIN ratings_score AS rs
	   ON rs.rating_id = r.rating_id;

-- library test
SELECT *
  FROM rawg.games AS g
	   INNER JOIN library AS l
	   ON l.game_id = g.game_id
	   INNER JOIN library_status AS ls
	   ON ls.library_id = l.library_id;

-- platform test
SELECT *
  FROM rawg.games AS g
	   INNER JOIN parent_platform AS pp
	   ON pp.game_id = g.game_id
	   INNER JOIN platform_details AS pd
	   ON pd.platform_id = pp.platform_id;

-- store test
SELECT *
  FROM rawg.games AS g
	   INNER JOIN store AS s
	   ON s.game_id = g.game_id
	   INNER JOIN store_details AS sd
	   ON sd.store_id = s.store_id;

-- genre & tag test
SELECT *
  FROM rawg.games AS g
	   INNER JOIN genres AS gr
	   ON gr.game_id = g.game_id
	   INNER JOIN tags AS t
	   ON t.game_id = g.game_id;
       
-- developer & publisher test
SELECT *
  FROM rawg.games AS g
	   INNER JOIN developers AS d
	   ON d.game_id = g.game_id
	   INNER JOIN publishers AS p
	   ON p.game_id = g.game_id;