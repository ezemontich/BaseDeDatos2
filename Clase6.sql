SELECT first_name, last_name 
FROM actor a1 
WHERE EXISTS (SELECT * FROM actor a2 WHERE a1.last_name = a2.last_name AND a1.actor_id != a2.actor_id)
ORDER BY last_name;

#----#

SELECT first_name, last_name 
FROM actor a 
WHERE NOT EXISTS (SELECT * FROM film_actor fa WHERE a.actor_id != fa.actor_id);

#----#

SELECT first_name, last_name 
FROM customer c 
WHERE 1 = (SELECT COUNT(*) FROM rental r WHERE c.customer_id = r.customer_id);

#----#

SELECT first_name, last_name 
FROM customer c 
WHERE 1 < (SELECT COUNT(*) FROM rental r WHERE c.customer_id = r.customer_id);

#----#

SELECT first_name, last_name, f.title
FROM actor a, film f 
WHERE EXISTS (SELECT * FROM film_actor fa WHERE f.film_id = fa.film_id AND f.title = 'BETRAYED REAR' OR f.title = 'CATCH AMISTAD');

#----#

SELECT first_name, last_name, f.title
FROM actor a, film f 
WHERE EXISTS (SELECT * FROM film_actor fa WHERE f.film_id = fa.film_id AND f.title = 'BETRAYED REAR');

#----#

SELECT first_name, last_name, f.title
FROM actor a, film f 
WHERE EXISTS (SELECT * FROM film_actor fa WHERE f.film_id = fa.film_id AND f.title = 'BETRAYED REAR' AND f.title = 'CATCH AMISTAD');

#----#

SELECT first_name, last_name, f.title
FROM actor a, film f 
WHERE NOT EXISTS (SELECT * FROM film_actor fa WHERE f.film_id = fa.film_id AND f.title = 'BETRAYED REAR' OR f.title = 'CATCH AMISTAD');