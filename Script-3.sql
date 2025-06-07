SELECT title
FROM film
WHERE rating = 'R';


SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 30 AND 40;

SELECT title
FROM film
WHERE language_id = original_language_id;

SELECT title, length
FROM film
ORDER BY length ASC;

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'ALLEN'

SELECT rating, COUNT(*) AS total_peliculas
FROM film
GROUP BY rating
ORDER BY rating;

SELECT title
FROM film
WHERE rating = 'PG-13' OR length > 180;

SELECT STDDEV(replacement_cost) AS variabilidad_reemplazo
FROM film;

SELECT 
    MAX(length) AS mayor_duracion,
    MIN(length) AS menor_duracion
FROM film;


SELECT amount, payment_date
FROM payment
ORDER BY payment_date DESC
OFFSET 2 LIMIT 1;


SELECT title
FROM film
WHERE rating NOT IN ('NC-17', 'G');


SELECT rating, AVG(length) AS promedio_duracion
FROM film
GROUP BY rating
ORDER BY rating;


SELECT title
FROM film
WHERE length > 180;


SELECT SUM(amount) AS total_ingresos
FROM payment;


SELECT customer_id, first_name, last_name
FROM customer
ORDER BY customer_id DESC
LIMIT 10;


SELECT first_name, last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'EGG IGBY';


SELECT DISTINCT title
FROM film
ORDER BY title;

SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy' AND f.length > 180;


SELECT c.name AS categoria, ROUND(AVG(f.length), 2) AS promedio_duracion
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110
ORDER BY promedio_duracion DESC;

SELECT AVG(rental_duration) AS media_dias_alquiler
FROM film;

SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM actor;

SELECT DATE(rental_date) AS fecha_alquiler, COUNT(*) AS total_alquileres
FROM rental
GROUP BY DATE(rental_date)
ORDER BY total_alquileres DESC;

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length) FROM film
)
ORDER BY length DESC;


SELECT 
    TO_CHAR(rental_date, 'YYYY-MM') AS mes,
    COUNT(*) AS total_alquileres
FROM rental
GROUP BY mes
ORDER BY mes;

SELECT 
    ROUND(AVG(amount), 2) AS promedio,
    ROUND(STDDEV(amount), 2) AS desviacion_estandar,
    ROUND(VARIANCE(amount), 2) AS varianza
FROM payment;

SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate) FROM film
)
ORDER BY rental_rate DESC;


SELECT actor_id, COUNT(film_id) AS total_peliculas
FROM film_actor
GROUP BY actor_id
HAVING COUNT(film_id) > 40
ORDER BY total_peliculas DESC;


SELECT f.title, 
       f.film_id,
       COALESCE((
           SELECT COUNT(*) 
           FROM inventory i
           WHERE i.film_id = f.film_id 
             AND inventory_in_stock(i.inventory_id)
       ), 0) AS cantidad_disponible
FROM film f
ORDER BY cantidad_disponible DESC;


SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS numero_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY numero_peliculas DESC;



SELECT 
    f.title AS pelicula,
    a.first_name AS nombre_actor,
    a.last_name AS apellido_actor
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id
ORDER BY f.title, a.last_name, a.first_name;



SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    f.title AS pelicula
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id
ORDER BY a.last_name, a.first_name, f.title;


SELECT 
    f.film_id,
    f.title,
    r.rental_id,
    r.rental_date,
    r.return_date,
    r.customer_id
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title, r.rental_date;


SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_gastado DESC
LIMIT 5;


SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'JOHNNY';


SELECT 
    first_name AS Nombre,
    last_name AS Apellido
FROM actor;


SELECT 
    MIN(actor_id) AS id_minimo,
    MAX(actor_id) AS id_maximo
FROM actor;


SELECT COUNT(*) AS total_actores
FROM actor;


SELECT *
FROM actor
ORDER BY last_name ASC;


SELECT *
FROM film
LIMIT 5;


SELECT first_name, COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC;


SELECT 
    rental.rental_id,
    rental.rental_date,
    rental.return_date,
    customer.first_name,
    customer.last_name
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
ORDER BY rental.rental_date;


SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    rental.rental_id,
    rental.rental_date,
    rental.return_date
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
ORDER BY customer.customer_id, rental.rental_date;


SELECT 
    film.film_id,
    film.title,
    category.category_id,
    category.name AS category_name
FROM film
CROSS JOIN category;


SELECT DISTINCT
    actor.actor_id,
    actor.first_name,
    actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film_category ON film_actor.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Action'
ORDER BY actor.last_name, actor.first_name;


SELECT COUNT(*)
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id IS NULL;


SELECT 
    actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) AS cantidad_peliculas
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY cantidad_peliculas DESC;


CREATE VIEW actor_num_peliculas AS
SELECT 
    actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) AS cantidad_peliculas
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name;


SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_alquileres
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_alquileres DESC;


SELECT 
    SUM(film.length) AS duracion_total_minutos
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Action';


CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_alquileres
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name;

SELECT * FROM cliente_rentas_temporal ORDER BY total_alquileres DESC;


CREATE TEMP TABLE peliculas_alquiladas AS
SELECT 
    film.film_id,
    film.title,
    COUNT(rental.rental_id) AS total_alquileres
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, film.title
HAVING COUNT(rental.rental_id) >= 10;


SELECT DISTINCT film.title
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE customer.first_name = 'TAMMY'
  AND customer.last_name = 'SANDERS'
  AND rental.return_date IS NULL
ORDER BY film.title ASC;


SELECT DISTINCT 
    actor.first_name,
    actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film_category ON film_actor.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Sci-Fi'
ORDER BY actor.last_name ASC, actor.first_name ASC;


SELECT DISTINCT 
    actor.first_name,
    actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_date > (
    SELECT MIN(rental.rental_date)
    FROM film
    JOIN inventory ON film.film_id = inventory.film_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    WHERE film.title = 'SPARTACUS CHEAPER'
)
ORDER BY actor.last_name, actor.first_name;


SELECT 
    actor.first_name,
    actor.last_name
FROM actor
WHERE NOT EXISTS (
    SELECT 1
    FROM film_actor
    JOIN film_category ON film_actor.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    WHERE film_actor.actor_id = actor.actor_id
      AND category.name = 'Music'
)
ORDER BY actor.last_name, actor.first_name;


SELECT DISTINCT film.title
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.return_date IS NOT NULL
  AND rental.return_date - rental.rental_date >  '8 days'
ORDER BY film.title;


SELECT DISTINCT
    f.title
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Animation';

SELECT title
FROM film
WHERE length = (
    SELECT length
    FROM film
    WHERE title = 'DANCING FEVER'
);


SELECT 
    customer.first_name,
    customer.last_name,
    COUNT(DISTINCT inventory.film_id) AS peliculas_distintas
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(DISTINCT inventory.film_id) >= 7
ORDER BY customer.last_name ASC, customer.first_name ASC;


SELECT 
    category.name AS categoria,
    COUNT(rental.rental_id) AS total_alquileres
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY total_alquileres DESC;


SELECT 
    category.name AS categoria,
    COUNT(film.film_id) AS total_peliculas
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE film.release_year = 2006
GROUP BY category.name;


SELECT 
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    store.store_id
FROM staff
CROSS JOIN store
ORDER BY staff.last_name, store.store_id;


SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_alquileres
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name;


































