
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS 'Nombre',
    a.address,
    ci.city
FROM customer c
    INNER JOIN store s USING(store_id)
    INNER JOIN address a ON s.address_id = a.address_id
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id)
WHERE co.country = 'Argentina';

Empty set (0.10 sec)

#------#

/*usa param*/
SELECT
    f.title,
    l.name,
    f.rating,
    CASE
        WHEN f.rating LIKE 'G' THEN 'All ages admitted'
        WHEN f.rating LIKE 'PG' THEN 'Some material may not be suitable for children'
        WHEN f.rating LIKE 'PG-13' THEN 'Some material may be inappropriate for children under 13'
        WHEN f.rating LIKE 'R' THEN 'Under 17 requires accompanying parent or adult guardian'
        WHEN f.rating LIKE 'NC-17' THEN 'No one 17 and under admitted'
    END 'Rating Text'
FROM film f
    INNER JOIN language l USING(language_id)
    WHERE l.language_id LIKE 1 ;
/*if using another language id, not english it will show an empty set*/

#--------#

SELECT  CONCAT(ac.first_name, ' ', ac.last_name) AS 'actor',
        f.title AS 'movie name',
        f.release_year AS 'release_year'
FROM film f
INNER JOIN film_actor USING(film_id)
INNER JOIN actor ac USING(actor_id)
WHERE CONCAT(first_name, ' ', last_name) LIKE TRIM(UPPER('ED CHASE'));

#--------#

SELECT
    f.title,
    r.rental_date,
    c.first_name,
    CASE
        WHEN r.return_date IS NOT NULL THEN 'Yes, it was returned'
        ELSE 'No it was not returned'
    END 'Returned'
FROM rental r
    INNER JOIN inventory i USING(inventory_id)
    INNER JOIN film f USING(film_id)
    INNER JOIN customer c USING(customer_id)
WHERE
    MONTH(r.rental_date) = '05'
    OR MONTH(r.rental_date) = '06'
ORDER BY r.rental_date; 

#--------#

MySQL CAST allows you to cast data from one data type to another data type, while CONVERT is used for converting a value from one datatype to a different datatype and for converting a value from one character set to another character set.
example of convert: CONVERT(value, type)
example of cast: CAST(value AS datatype)

#--------#

ISNULL replaced the Oracle NVL function in the SQL server. When an expression in SQL server is NULL, the ISNULL function allows you to return an alternative value for the null. ISNULL checks whether the value or an expression is true or false.
