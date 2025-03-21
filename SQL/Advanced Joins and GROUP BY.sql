## Advanced Joins and GROUP BY 

-- this section is created using Mavenmovies database 
---------------------------------------------------------------------------------
USE mavenmovies;
---------------------------------------------------------------------------------
-- Question 13: Display the top 5 rented movies along with the number of times they've been rented
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;
---------------------------------------------------------------------------------
-- Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2)
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id = 1
AND c.customer_id IN (
    SELECT c2.customer_id
    FROM customer c2
    JOIN rental r2 ON c2.customer_id = r2.customer_id
    JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
    WHERE i2.store_id = 2
)
GROUP BY c.customer_id, c.first_name, c.last_name;