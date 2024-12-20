USE sakila;

-- 1. List the number of films per category.
SELECT c.category_id, c.name AS category_name, count(f.film_id) AS pelis_por_categoria
 FROM film AS f
  INNER JOIN film_category AS fc ON (f.film_id=fc.film_id)
  INNER JOIN category AS c ON (fc.category_id=c.category_id)
  GROUP BY c.category_id,c.name;
 
-- 2. Retrieve the store ID, city, and country for each store.
SELECT s.store_id, c.city, p.country
 FROM store AS s
  INNER JOIN address AS a ON (s.address_id=a.address_id)
  INNER JOIN city AS c ON (a.city_id=c.city_id)
  INNER JOIN country AS p ON (c.country_id=p.country_id);

-- 3. Calculate the total revenue generated by each store in dollars.
 SELECT s.store_id, SUM(p.amount) AS revenue
  FROM store s
   INNER JOIN inventory i ON (s.store_id=i.store_id)
   INNER JOIN rental r ON (i.inventory_id=r.inventory_id)
   INNER JOIN payment p ON (r.rental_id=p.rental_id)
   GROUP BY s.store_id;

-- 4. Determine the average running time of films for each category.
SELECT c.category_id, c.name AS category_name, AVG(length)
 FROM film AS f
  INNER JOIN film_category AS fc ON (f.film_id=fc.film_id)
  INNER JOIN category AS c ON (fc.category_id=c.category_id)
   GROUP BY c.category_id, c.name;
   
-- BONUS ------------------------------------------------
-- 5. Identify the film categories with the longest average running time.
SELECT c.category_id, c.name AS category_name, AVG(length) AS avg_time
 FROM film AS f
  INNER JOIN film_category AS fc ON (f.film_id=fc.film_id)
  INNER JOIN category AS c ON (fc.category_id=c.category_id)
   GROUP BY c.category_id, c.name
    ORDER BY avg_time DESC
     LIMIT 1;

-- 6. Display the top 10 most frequently rented movies in descending order.
SELECT f.film_id, f.title, count(r.rental_id) AS num_rentals
   FROM film f
     INNER JOIN inventory i ON (f.film_id=i.film_id)
     INNER JOIN rental r ON (i.inventory_id=r.inventory_id)
     GROUP BY f.film_id, f.title
      ORDER BY num_rentals DESC
       LIMIT 10;

-- 7. Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT f.film_id, f.title, r.return_date
 FROM film f
  LEFT JOIN inventory i ON (f.film_id=i.film_id)
  LEFT JOIN rental r ON (i.inventory_id=r.inventory_id)
  WHERE f.title='Academy Dinosaur' AND i.store_id=1
   ORDER BY return_date;

-- 8. Provide a list of all distinct film titles, along with their availability status in the inventory. 
-- Include a column indicating whether each title is 'Available' or 'NOT available.' 
-- Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
SELECT DISTINCT f.title, 
 CASE WHEN IFNULL(i.inventory_id,0)=0 THEN 'NOT available' ELSE 'Available' END AS Availability
 FROM film f
  LEFT JOIN inventory i ON (f.film_id=i.film_id);
