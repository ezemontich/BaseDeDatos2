
SELECT a.postal_code
FROM address a
WHERE a.postal_code IN(SELECT a2.address_id
                       FROM address a2
                       INNER JOIN staff s USING(address_id))
ORDER BY postal_code;

#0,04 segungos sin index
#0,00 segundos con index

SELECT a.postal_code, ci.city, co.country
FROM address a
INNER JOIN city ci USING(city_id)
INNER JOIN country co USING(country_id)
WHERE postal_code BETWEEN 2000 AND 5000
ORDER BY postal_code;

#0,02 segundos sin index
#0,00 segundos con index

CREATE INDEX postalCode on address(postal_code);

#------#

SELECT first_name
FROM actor
WHERE first_name LIKE "R%"
ORDER BY first_name;

SELECT last_name
FROM actor
WHERE last_name LIKE "%S"
ORDER BY last_name;

#la query de last name es más rápida porque tiene index

#------#

SELECT description
FROM film
WHERE description LIKE "%FAST%"
ORDER BY description;

#0,00 segundos

SELECT description
FROM film_text
WHERE MATCH(description) AGAINST("FAST")
ORDER BY description;
	
#0,01 segundos
