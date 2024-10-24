-- LEVEL 1

-- Question 1: Number of users with sessions
SELECT COUNT(DISTINCT u.id) AS Users_with_sessions
 FROM users u INNER JOIN sessions s ON (u.id=s.user_id)
   ORDER BY u.id;
   
-- Question 2: Number of chargers used by user with id 1
SELECT COUNT(DISTINCT s.charger_id)
 FROM users u INNER JOIN sessions s ON (u.id=s.user_id)
  WHERE u.id=1;



-- LEVEL 2

-- Question 3: Number of sessions per charger type (AC/DC):
SELECT c.type,COUNT(s.id) AS num_sesiones
 FROM chargers c LEFT JOIN sessions s ON (s.charger_id=c.id)
	GROUP BY c.type;
  

-- Question 4: Chargers being used by more than one user
SELECT COUNT(sub.id)
FROM (
	SELECT c.id,c.label,COUNT(DISTINCT s.user_id)
	 FROM chargers c LEFT JOIN sessions s ON (s.charger_id=c.id)
	  GROUP BY c.id,c.label
) AS sub;

-- Question 5: Average session time per charger
SELECT c.id,c.label,AVG(TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time)) AS minutes
 FROM chargers c LEFT JOIN sessions s ON (s.charger_id=c.id)
  GROUP BY c.id,c.label;




-- LEVEL 3

-- Question 6: Full username of users that have used more than one charger in one day (NOTE: for date only consider start_time)
WITH cte AS(
SELECT u.name,u.surname,DATE(s.start_time) AS _day,COUNT(DISTINCT s.charger_id) AS num_cargadores
 FROM users u 
  INNER JOIN sessions s ON (u.id=s.user_id)
   GROUP BY u.name,u.surname,DATE(s.start_time)
   HAVING COUNT(DISTINCT s.charger_id) > 1
   ORDER BY u.name,u.surname,DATE(s.start_time)
)
SELECT name, surname
 FROM cte
  GROUP BY name, surname;
 

-- Question 7: Top 3 chargers with longer sessions
SELECT c.id, c.label, c.type, TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time) AS session_length
	FROM chargers c INNER JOIN sessions s ON (c.id=s.charger_id)
		ORDER BY session_length DESC
		 LIMIT 3;

-- Question 8: Average number of users per charger (per charger in general, not per charger_id specifically)
WITH cte AS (
SELECT 
	c.id AS charger_id, 
    COUNT(DISTINCT u.id) AS num_users
 FROM chargers c 
	INNER JOIN sessions s ON (c.id=s.charger_id)
    INNER JOIN users u ON (u.id=s.user_id)
    GROUP BY c.id
)
SELECT SUM(num_users) / COUNT(charger_id) AS average_users_per_charger
	FROM cte;

-- Question 9: Top 3 users with more chargers being used
SELECT u.name,u.surname,COUNT(DISTINCT s.charger_id) AS num_cargadores
 FROM users u 
  INNER JOIN sessions s ON (u.id=s.user_id)
   GROUP BY u.name,u.surname
   ORDER BY num_cargadores DESC
    LIMIT 3;


-- LEVEL 4

-- Question 10: Number of users that have used only AC chargers, DC chargers or both
DROP VIEW users_chargers;
CREATE VIEW users_chargers AS 
SELECT DISTINCT u.id AS user_id, c.type
 FROM users u 
  INNER JOIN sessions s ON (u.id=s.user_id)
  INNER JOIN chargers c ON (s.charger_id=c.id)
   ORDER BY u.id;

DROP VIEW users_type;
CREATE VIEW users_type AS    
SELECT 
	user_id,
    type,
    COUNT(type) OVER(PARTITION BY user_id) AS num_tipos
	FROM users_chargers;

SELECT * 
 FROM users_type;
    
SELECT type,COUNT(*) 
 FROM users_type
  WHERE num_tipos=1 AND type='AC'
UNION
SELECT type,COUNT(*) 
 FROM users_type
  WHERE num_tipos=1 AND type='DC'
UNION
SELECT 'both',COUNT(DISTINCT user_id) 
 FROM users_type
  WHERE num_tipos=2;

-- Question 11: Monthly average number of users per charger
DROP VIEW monthly_sessions;
CREATE VIEW monthly_sessions AS    
SELECT 
    DATE_FORMAT(CONVERT(s.start_time,DATE), '%M') AS _month,
    DATE_FORMAT(CONVERT(s.start_time,DATE), '%m') AS _month_number,
    s.charger_id,
    s.user_id
 FROM sessions s;
 
WITH cte AS (
SELECT _month, _month_number, charger_id, COUNT(DISTINCT user_id) as users_per_charger
 FROM monthly_sessions
  GROUP BY _month, _month_number, charger_id
)
SELECT _month, SUM(users_per_charger) / COUNT(charger_id) AS monthly_average
	FROM cte
     GROUP BY _month; -- Mismo resultado que la pregunta 8, puesto que tenemos sesiones en un único mes.

-- Question 12: Top 3 users per charger (for each charger, number of sessions)
DROP VIEW top_users;
CREATE VIEW top_users AS  
SELECT s.charger_id,s.user_id,COUNT(s.id) AS num_sessions,
 DENSE_RANK() OVER(PARTITION BY charger_id ORDER BY COUNT(s.id) DESC) as ranking
 FROM sessions s
  GROUP BY s.charger_id,s.user_id
   ORDER BY s.charger_id;

WITH cte AS (   
	SELECT charger_id,user_id,num_sessions,ranking,
		ROW_NUMBER() OVER(PARTITION BY charger_id ORDER BY ranking) AS fila
		FROM top_users
)
SELECT charger_id, user_id, name, surname 
  FROM cte LEFT JOIN users u ON (cte.user_id=u.id)
   where fila<=3;


-- LEVEL 5

-- Question 13: Top 3 users with longest sessions per month (consider the month of start_time)
DROP VIEW users_month;
CREATE VIEW users_month AS    
SELECT u.id, u.name, u.surname, MONTH(s.start_time) AS _month, TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time) As session_length
 FROM users u 
  INNER JOIN sessions s ON (u.id=s.user_id);    

SELECT name, surname, session_length,
 DENSE_RANK() OVER(ORDER BY session_length DESC) as ranking
 FROM users_month
 LIMIT 3;
  
-- Question 14. Average time between sessions for each charger for each month (consider the month of start_time)
DROP VIEW monthly_sessions;
CREATE VIEW monthly_sessions AS    
SELECT 
	charger_id,
    user_id,
    DATE_FORMAT(CONVERT(start_time,DATE), '%M') AS _month,
    DATE_FORMAT(CONVERT(start_time,DATE), '%m') AS _month_number,
    start_time,
    end_time,
    LAG(end_time,1) OVER(PARTITION BY charger_id, user_id ORDER BY charger_id, user_id, start_time) AS previous_end_time
 FROM sessions;

-- NOTA: No se puede resolver porque hay sesiones de un mismo usuario que se solapan!!!
-- 	Pero se resolvería así:
SELECT _month, charger_id, AVG(TIMESTAMPDIFF(MINUTE, start_time, previous_end_time)) as average_time_between_sessions
 FROM monthly_sessions
  GROUP BY _month, charger_id;







