use sakila;

-- 1. Display all available tables in the Sakila database.
show tables;

-- 2. Retrieve all the data from the tables actor, film and customer.
select * from actor;
select * from film;
select * from customer;

-- 3. Retrieve the following columns from their respective tables:
-- 3.1 Titles of all films from the film table
select title from film order by 1;

-- 3.2 List of languages used in films, with the column aliased as language from the language table
select name as language from language order by 1;

-- 3.3 List of first names of all employees from the staff table
select first_name from staff;

-- 4. Retrieve unique release years.
select distinct release_year from film;

-- 5. Counting records for database insights:
-- 5.1 Determine the number of stores that the company has.
select count(*) from store; -- 2

-- 5.2 Determine the number of employees that the company has.
select count(*) from staff; -- 2

-- 5.3 Determine how many films are available for rent and how many have been rented.
select count(*) from film; -- 1000 films available

select * from rental;
select * from inventory;
-- Método A) 958 films have been rented
select count(distinct film_id) from inventory
 where inventory_id IN (select distinct inventory_id from rental);
-- Método B) 958
select count(distinct film_id) from inventory as i
 inner join rental as r on i.inventory_id=r.inventory_id;

-- 5.4 Determine the number of distinct last names of the actors in the database.
select count(distinct last_name) from actor; -- 121


-- 6. Retrieve the 10 longest films.
select film_id, title, length 
 from film 
  order by length desc
   limit 10;
   
-- 7. Use filtering techniques in order to:
-- 7.1 Retrieve all actors with the first name "SCARLETT".
select * from actor
 where first_name='SCARLETT';  
 
-- 7.2 Retrieve all movies that have ARMAGEDDON in their title and have a duration longer than 100 minutes.
select film_id, title from film
 where title like '%ARMAGEDDON%' and length > 100;
 
-- 7.3 Determine the number of films that include Behind the Scenes content
select count(*) from film
 where special_features like '%Behind the Scenes%'; -- 538
