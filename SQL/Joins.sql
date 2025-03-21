## Joins
-- this section is created using Mavenmovies database 
---------------------------------------------------------------------------------
USE mavenmovies;
---------------------------------------------------------------------------------
-- Question 9: Display the title of the movie, customer’s first name, and last name who rented it
SELECT f.title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;
---------------------------------------------------------------------------------
-- Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind.
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = "Gone with the Wind";
---------------------------------------------------------------------------------
-- Question 11: Retrieve the customer names along with the total amount they've spent on rentals
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name;
---------------------------------------------------------------------------------
-- Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London')
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ct.city = 'London'
GROUP BY c.first_name, c.last_name, f.title;