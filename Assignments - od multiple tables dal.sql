USE mavenmovies;

/* Assignment 1: všechny názvy filmů, popisky, jejich store_id a inventory_id */
SELECT *
FROM film;

SELECT *
FROM inventory;

SELECT
	inventory.inventory_id,
    inventory.store_id,
    film.title,
    film.description
FROM inventory
	INNER JOIN film
		ON inventory.film_id = film.film_id /*původně jsem tady měl chybu, protože jsem spojoval skrze sloupce inventory_id v jedné tabulce a film_id v druhé, 
        což jsou logicky jiné hodnoty žejo, takže mi to spojovalo skrze hodnoty, které mají jiný význam, takže spoj byl "falešný"*/
ORDER BY inventory_id
LIMIT 5000;

/* Assignment 2: kolik herců je listováno pro každý film --> list všech titulů a zjistit, kolik herců je spojeno s každým z nich*/
SELECT *
FROM film;
SELECT *
FROM film_actor;

SELECT
	film.title,
	COUNT(film_actor.film_id) AS number_of_actors
FROM film
	LEFT JOIN film_actor
		ON film.film_id = film_actor.film_id
GROUP BY film.title;

/* Assignment 3: list všech herců s každým filmem, kde hrají (jméno, příjmení, název filmu)*/
SELECT
	actor.first_name,
    actor.last_name,
    film.title
FROM actor
	INNER JOIN film_actor
		ON actor.actor_id = film_actor.actor_id
	INNER JOIN film
		ON film_actor.film_id = film.film_id
ORDER BY actor.last_name, actor.first_name
LIMIT 6000;

/* Assignment 4: list unikátních titulů a jejich popisků, které jsou skladem v obchodě 2 - NEsmím použít WHERE dle zadání*/
SELECT DISTINCT
	film.title,
    film.description
FROM film
	INNER JOIN inventory
		ON film.film_id = inventory.film_id AND inventory.store_id = 2;

/* Assignment 5: list všech zaměstnanců a poradců a sloupce, kdo jsou */
SELECT
	"advisor" AS role,
	first_name,
    last_name
FROM advisor
UNION
SELECT
	"staff" AS role,
	first_name,
    last_name
FROM staff;