USE sakila;

-- CHALLENGE 1 ------------------------------------------------------
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT min(length) as min_duration, max(length) as max_duration
 FROM film;
 
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT AVG(length) as average, 
floor(AVG(length)/60) as hours, 
ROUND((AVG(length)/60 - floor(AVG(length)/60)) * 60) as minutes
 FROM film;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT min(rental_date), max(rental_date), DATEDIFF(max(rental_date), min(rental_date)) as Days_of_operation
 FROM rental;
 
 -- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
 SELECT *, DATE_FORMAT(rental_date, '%M') as month, DATE_FORMAT(rental_date, '%W') AS weekday 
  FROM rental
   LIMIT 20;
   
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.   
SELECT *, 
 DATE_FORMAT(rental_date, '%M') as month, DATE_FORMAT(rental_date, '%W') AS weekday,
 WEEKDAY(rental_date) AS weekday_index,
 CASE WHEN WEEKDAY(rental_date) > 4 THEN 'weekend' ELSE 'workday' END as DAY_TYPE
  FROM rental;
  
-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.  
SELECT title, IFNULL(rental_duration, 'Not Available') as rental_duration
 FROM film
  ORDER BY title ASC;
  
-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, 
-- along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.  
SELECT *, CONCAT(first_name, ' ', last_name) as Name_and_Surname, substr(email,1,3) as Email_first3 
 FROM customer
  ORDER BY last_name ASC;

 
-- CHALLENGE 2 ------------------------------------------------------
-- 1.1 The total number of films that have been released.
SELECT COUNT(*) 
 FROM film; -- 1000
 
-- 1.2 The number of films for each rating.
SELECT rating,COUNT(*) 
 FROM film
	GROUP BY rating
     ORDER BY 1;
     
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.     
SELECT rating,COUNT(*) as cuantos
 FROM film
	GROUP BY rating
     ORDER BY cuantos DESC;
     
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.     
SELECT rating,ROUND(AVG(length),2) as mean_duration
 FROM film
	GROUP BY rating
     ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating,ROUND(AVG(length),2) as mean_duration
 FROM film
	GROUP BY rating
     HAVING mean_duration > 120
      ORDER BY mean_duration DESC;
      
-- 3. Bonus: determine which last names are not repeated in the table actor.      
SELECT last_name
 FROM actor
   GROUP BY last_name
      HAVING COUNT(*) = 1;
 