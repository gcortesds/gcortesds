/* COUNT OF STORES */
SELECT COUNT(DISTINCT store_id)
FROM store;

/* MOST POPULAR STORE BY NUMBER OF CUSTOMERS */
SELECT store_id, address, city, country, COUNT(DISTINCT customer_id) AS customer_number
FROM store
INNER JOIN address USING(address_id)
INNER JOIN city USING(city_id)
INNER JOIN country USING(country_id)
INNER JOIN customer USING(store_id)
GROUP BY store_id;

/* TOTAL REVENUE */
SELECT SUM(amount)
FROM payment;

/* MOST PROFITABLE STORE */
SELECT store_id,
SUM(amount) AS total_sales
FROM store
INNER JOIN staff USING(store_id)
INNER JOIN payment USING(staff_id)
GROUP BY store_id;

/* MOST POPULAR FILM */
SELECT
film_id,
film.title,
category.name AS category,
COUNT(*) AS times_rented
FROM inventory
LEFT JOIN rental USING(inventory_id)
LEFT JOIN film USING(film_id)
LEFT JOIN film_category USING(film_id)
LEFT JOIN category USING(category_id)
GROUP BY film_id
ORDER BY 4 DESC -- times rented
LIMIT 10;

/* AVERAGE RENTAL DURATION */
SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_time
FROM rental;

/* ARE SHORT OR LONG RENTALS MORE PROFITABLE? */
SELECT
SUM(CASE
WHEN DATEDIFF(return_date, rental_date) >= 5.0252 THEN amount
ELSE 0
END) AS long_rental_revenue,
SUM(CASE
WHEN DATEDIFF(return_date, rental_date) < 5.0252 THEN amount
ELSE 0
END) AS short_rental_revenue
FROM payment
INNER JOIN rental USING(rental_id);

/* MOST POPULAR GENRE */
SELECT
category.name AS category,
COUNT(rental_id) AS times_rented
FROM rental
INNER JOIN inventory USING(inventory_id)
INNER JOIN film USING(film_id)
INNER JOIN film_category USING(film_id)
INNER JOIN category USING(category_id)
GROUP BY name
ORDER BY 2 DESC -- times_rented
;

/* MOST POPULAR ACTORS */
SELECT
actor_id, 
first_name,
last_name,
COUNT(rental_id) AS times_rented
FROM rental
INNER JOIN inventory USING(inventory_id)
INNER JOIN film USING(film_id)
INNER JOIN film_actor USING(film_id)
INNER JOIN actor USING(actor_id)
GROUP BY actor_id
ORDER BY 4 DESC -- times_rented
LIMIT 10
;

/* TOP 10 COSTUMERS */
SELECT customer_id,
count(rental_id) AS times_rented
FROM rental
GROUP BY customer_id
ORDER BY times_rented DESC
LIMIT 10;

/* EXPLORING OUR TOP BUYER BEHAVIOR */
SELECT customer_id, name,
COUNT(name) AS times_rented
FROM rental
INNER JOIN inventory USING(inventory_id)
INNER JOIN film USING(film_id)
INNER JOIN film_category USING(film_id)
INNER JOIN category USING(category_id)
WHERE customer_id = 148
GROUP BY name
ORDER BY times_rented DESC;