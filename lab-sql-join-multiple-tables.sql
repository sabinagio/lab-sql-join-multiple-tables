USE sakila;

# 1. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country 
FROM store
JOIN address
USING(address_id)
JOIN city
USING(city_id)
JOIN country
USING(country_id);

# 2. Write a query to display how much business, in dollars, each store brought in.

# Connecting through staff table
SELECT store_id, ROUND(SUM(amount), 0) AS total_business
FROM store
LEFT JOIN staff
USING(store_id)
LEFT JOIN payment
USING(staff_id)
GROUP BY store_id;  # $33K & $33K

# Connecting through customer table
SELECT store_id, ROUND(SUM(amount), 0) AS total_business
FROM store
LEFT JOIN customer
USING(store_id)
LEFT JOIN payment
USING(customer_id)
GROUP BY store_id; # $36K & $30K

SELECT DISTINCT staff_id FROM payment;

#3. What is the average running time of films by category?
SELECT name, ROUND(AVG(length), 0) AS average_running_time
FROM film
JOIN film_category
USING(film_id)
JOIN category
USING(category_id)
GROUP BY name;

# 4. Which film categories are longest?
SELECT name, ROUND(AVG(length), 0) AS average_running_time
FROM film
JOIN film_category
USING(film_id)
JOIN category
USING(category_id)
GROUP BY name
ORDER BY average_running_time DESC
LIMIT 5;  # Sports & Games

# 5. Display the most frequently rented movies in descending order.
SELECT title, COUNT(rental_id) AS rental_count
FROM film
JOIN inventory
USING(film_id)
JOIN rental
USING(inventory_id)
GROUP BY title
ORDER BY rental_count DESC
LIMIT 5; # Bucket Brotherhood, Rocketeer Mother

# 6. List the top five genres in gross revenue in descending order.
SELECT name, ROUND(SUM(amount), 0) AS gross_revenue
FROM category
LEFT JOIN film_category
USING(category_id)
LEFT JOIN film
USING(film_id)
LEFT JOIN inventory
USING(film_id)
LEFT JOIN rental
USING(inventory_id)
LEFT JOIN payment
USING(rental_id)
GROUP BY name
ORDER BY gross_revenue DESC
LIMIT 5;  # Sports ($5.1K), Sci-Fi ($4.6K)

# 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT title, COUNT(*) AS number_of_copies
FROM film
LEFT JOIN inventory
USING(film_id)
WHERE title = "Academy Dinosaur"
AND store_id = 1; # The movie is available in 4 copies
