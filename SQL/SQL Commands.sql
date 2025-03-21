## SQL Commands

-- this section is created using Mavenmovies database 
---------------------------------------------------------------------------------
USE Mavenmovies;

-- 1. Identify the primary keys and foreign keys in MavenMovies DB.
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'MavenMovies';
---------------------------------------------------------------------------------
-- 2. List all details of actors.
SELECT * FROM actor;
---------------------------------------------------------------------------------
-- 3. List all customer information from DB.
SELECT * FROM customer;
---------------------------------------------------------------------------------
-- 4. List different countries.
SELECT DISTINCT country FROM country;
---------------------------------------------------------------------------------
-- 5. Display all active customers.
SELECT * FROM customer WHERE active = 1;
---------------------------------------------------------------------------------
-- 6. List all rental IDs for customer with ID 1.
SELECT rental_id FROM rental WHERE customer_id = 1;
---------------------------------------------------------------------------------
-- 7. Display all the films whose rental duration is greater than 5.
SELECT * FROM film WHERE rental_duration > 5;
---------------------------------------------------------------------------------
-- 8. List the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT COUNT(*) AS total_films FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;
---------------------------------------------------------------------------------
-- 9. Display the count of unique first names of actors.
SELECT COUNT(DISTINCT first_name) AS unique_actor_names FROM actor;
---------------------------------------------------------------------------------
-- 10. Display the first 10 records from the customer table.
SELECT * FROM customer LIMIT 10;
---------------------------------------------------------------------------------
-- 11. Display the first 3 records from the customer table whose first name starts with 'B'.
SELECT * FROM customer WHERE first_name LIKE 'B%' LIMIT 3;
---------------------------------------------------------------------------------
-- 12. Display the names of the first 5 movies rated as 'G'.
SELECT title FROM film WHERE rating = 'G' LIMIT 5;
---------------------------------------------------------------------------------
-- 13. Find all customers whose first name starts with "A".
SELECT * FROM customer WHERE first_name LIKE 'A%';
---------------------------------------------------------------------------------
-- 14. Find all customers whose first name ends with "A".
SELECT * FROM customer WHERE first_name LIKE '%A';
---------------------------------------------------------------------------------
-- 15. Display the list of first 4 cities that start and end with the same letter.
SELECT city FROM city WHERE LEFT(city,1) = RIGHT(city,1) LIMIT 4;
---------------------------------------------------------------------------------
-- 16. Find all customers whose first name contains "NC" in any position.
SELECT * FROM customer WHERE first_name LIKE '%NC%';
---------------------------------------------------------------------------------
-- 17. Find all customers whose first name has "R" in the second position.
SELECT * FROM customer WHERE first_name LIKE '_R%';
---------------------------------------------------------------------------------
-- 18. Find all customers whose first name starts with "A" and is at least 5 characters long.
SELECT * FROM customer WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;
---------------------------------------------------------------------------------
-- 19. Find all customers whose first name starts with "A" and ends with "O".
SELECT * FROM customer WHERE first_name LIKE 'A%O';
---------------------------------------------------------------------------------
-- 20. Get the films with PG and PG-13 rating using the IN operator.
SELECT * FROM film WHERE rating IN ('PG', 'PG-13');
---------------------------------------------------------------------------------
-- 21. Get the films with length between 50 to 100 using BETWEEN operator.
SELECT * FROM film WHERE length BETWEEN 50 AND 100;
---------------------------------------------------------------------------------
-- 22. Get the top 50 actors using LIMIT operator.
SELECT * FROM actor LIMIT 50;
---------------------------------------------------------------------------------
-- 23. Get the distinct film IDs from the inventory table.
SELECT DISTINCT film_id FROM inventory;
