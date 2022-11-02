SELECT title, rating, length from film
where length = (select min(length) from film);

#-------#

SELECT title, rating, length FROM film
WHERE length < ALL (SELECT min(length) FROM film);

#-------#

SELECT c.first_name AS nombre,c.last_name AS apellido, a.address AS Direccion,
	(SELECT min(amount) FROM payment p WHERE c.customer_id = p.customer_id ) AS Paga
FROM customer c
JOIN address a on c.address_id = a.address_id
ORDER BY c.first_name;


#--------#

SELECT c.first_name AS nombre,c.last_name AS apellido, a.address AS Direccion,
	(SELECT MIN(amount) FROM payment p WHERE c.customer_id = p.customer_id) AS Paga_Minima, 
    (SELECT MAX(amount) FROM payment p WHERE c.customer_id = p.customer_id ) AS paga_maxima
FROM customer c
JOIN address a on c.address_id = a.address_id
ORDER BY c.first_name
