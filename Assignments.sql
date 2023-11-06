USE mavenmovies;

-- assignment 1: jména, příjmení a email zákazníků
-- měl jsem chybu v syntaxu --> chyběly mi čárky mezi sloupečky
/*
SELECT
	first_name,
    last_name,
    email
FROM customer
ORDER BY last_name;

-- assignment 2: různé délky výpůjček - jaké?
SELECT DISTINCT rental_duration
FROM film;


-- assignment 3: všechny platby prvních 100 zákazníků (dle customer ID 1 až 100)
SELECT *
FROM payment
WHERE
	customer_id BETWEEN 1 AND 100;
    
-- assignment 4: platby nad 5 USD po 1.1.2006 pro prvních 100 zákazníků z minulého
SELECT *
FROM payment
WHERE customer_ID < 101
	AND amount > 5
	AND payment_date > "2006-01-01";
    
-- assignment 5: platby od zákazníků 42, 53, 60 a 75 + všechny platby nad 5 USD
SELECT *
FROM payment
WHERE
	amount > 5
    OR customer_id IN(42, 53, 60, 75)
ORDER BY customer_id;

-- assignment 5: chci list filmů, co mají "Behind the Scenes" jako featurku (tedy v názvu to asi bude)
SELECT
	title,
    special_features
FROM film
WHERE
	special_features LIKE "%Behind the Scenes%"
	OR special_features LIKE "%Behind the Scenes%"
    OR special_features LIKE "Behind the Scenes%"
    OR special_features LIKE "Behind the Scenes";
-- stačilo tam mít jen tu první podmínku, protože řeší znaky před NEBO po, takže pokryje druhá a třetí varianti, otázka jestli tu čtvrtou
-- a když budou před I  po???
*/
/* assignment 6: na jak dlouho bývají naše filmy půjčovány? --> počet filmů dle délky vypůjčky*/
/*
SELECT
	rental_duration AS days_of_rental,
    COUNT(film_id) AS number_of_films    
FROM film
GROUP BY rental_duration
ORDER BY rental_duration;
*/
/* assignment 7: chargujeme víc za vypůjčení, když je replacement cost vyšší --> asi teda replacement cost by AVG payment/fee nebo tak?
dle zadání to je počet filmů, průměr, min a max rental rate, seskupen dle replacement cost - zkusím prvně to svoje a uvidím*/
/*
SELECT
	replacement_cost,
    COUNT(film_id) AS count_of_films,
    MIN(rental_rate) AS minimum_rental_rate,
    MAX(rental_rate) AS maximum_rental_rate,
    AVG(rental_rate) AS avg_rental_rate
FROM film
GROUP BY replacement_cost
-- HAVING AVG(rental_rate) < 3        -- tohle tu nemusí být, jen si to dělám trochu víc analytisch
ORDER BY AVG(rental_rate) ASC;
*/
/* assignment 8: zákaznící s málo výpůjčkami, méně než 15*/
/*
SELECT
	customer_id,
    COUNT(rental_id) AS number_of_rentals
FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) < 15
ORDER BY COUNT(rental_id) DESC;
*/
/* assignment 9: jsou nejdelší filmy také ty nejdražší (jako výpůjčky)? --> řekl bych teda film_ids/titles jako dimenze*/
/*
SELECT
	rental_rate,
    AVG(length) AS avg_length
FROM film
GROUP BY rental_rate
ORDER BY AVG(length) DESC;
-- NEBO dle jejich detailed zadání
SELECT
	title,
    length AS length_in_minutes,
    rental_rate
FROM film
ORDER BY length DESC;

*/
/* JE TO HO UŽ ZASE HODNĚ --> DÁVÁM VŠE NAD TÍM DO POZNÁMKY*/

/* assignment 10: do jaké obchodu každý zákazník chodí a zda je nebo není aktivní? --> 
list jmen všech zákazníků a labely jako "store 1 nebo 2 + active nebo inactive"*/
SELECT DISTINCT
	first_name,
    last_name,
    CASE
		WHEN store_id = 1 AND active = 1 THEN "store 1 active"
        WHEN store_id = 1 AND active = 0 THEN "store 1 inactive"
        WHEN store_id = 2 AND active = 1 THEN "store 2 active"
        WHEN store_id = 2 AND active = 0 THEN "store 2 inactive"
        ELSE "check logic"
        END AS "store_X_activity"
FROM customer;

/* assignment 11: kolik neaktivních zákazníků máme v každém z obchodů? --> počet zákazníků rozpadnutý dle store_id (řádek) a aktivity (sloupec)
*/
SELECT
	store_id,
    COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS nr_of_active_customers, -- zatím je asi jedno, co dám po THEN, protože to počítá stejně
	COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS nr_of_inactive_customers,
    COUNT(active) as total_nr_of_customers
FROM customer
GROUP BY store_id;



