#1

DELIMITER $

CREATE FUNCTION get_amount(f_id INT, st_id INT) RETURNS 
INT DETERMINISTIC 
BEGIN 
	DECLARE cant INT;
	SELECT COUNT(i.inventory_id) INTO cant
	FROM film f
	    INNER JOIN inventory i USING(film_id)
	    INNER JOIN store st USING(store_id)
	WHERE
	    f.film_id = f_id
	    AND st.store_id = st_id;
	RETURN (cant);

END $
DELIMITER ;

SELECT get_amount(1,1);

#2

DELIMITER $
DROP PROCEDURE IF EXISTS list_procedure $

CREATE PROCEDURE list_procedure(IN co_name VARCHAR(250))
BEGIN
	DECLARE f_name VARCHAR(250);
	DECLARE l_name VARCHAR(250);
	DECLARE finished BOOLEAN DEFAULT FALSE;

	DECLARE cursList CURSOR FOR
	SELECT
	    c.first_name,
	    c.last_name
	FROM customer c
	    INNER JOIN address USING(address_id)
	    INNER JOIN city USING(city_id)
	    INNER JOIN country co USING(country_id) WHERE co.country = co_name;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;

	DROP TEMPORARY TABLE IF EXISTS tempTable;

	CREATE TEMPORARY TABLE tempTable(first_name VARCHAR(250), last_name VARCHAR(250));


	OPEN cursList;

	looplabel: LOOP
	FETCH cursList INTO f_name,l_name;

	IF finished = TRUE THEN
		LEAVE looplabel;
	END IF;

	INSERT INTO tempTable(first_name,last_name) VALUES (f_name, l_name);

	END LOOP looplabel;	

	CLOSE cursList;

	SELECT CONCAT(first_name,';',last_name) FROM tempTable;
END $

CALL list_procedure('Argentina') $
DELIMITER ;

#3

#Inventory in stock

SHOW CREATE FUNCTION inventory_in_stock;

/*
CREATE FUNCTION `inventory_in_stock`(p_inventory_id INT) RETURNS tinyint(1)
BEGIN
    DECLARE v_rentals INT;
    DECLARE v_out INT;
    SELECT COUNT(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;
    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;
    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;
    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END
This function returns TRUE or FALSE, depending if the inventory has stock or not.
*/

SELECT inventory_in_stock(40);

#Film in stock

SHOW CREATE PROCEDURE film_in_stock;

/*
CREATE PROCEDURE `film_in_stock`(IN p_film_id INT, IN p_store_id INT, OUT p_film_count INT)
BEGIN
     SELECT inventory_id
     FROM inventory
     WHERE film_id = p_film_id AND store_id = p_store_id AND inventory_in_stock(inventory_id);
     SELECT COUNT(*)
     FROM inventory
     WHERE film_id = p_film_id AND store_id = p_store_id AND inventory_in_stock(inventory_id)
     INTO p_film_count;
END
This procedure, if you call it, it will show you the different inventory_id that has the film_id and store_id that you send in the parameters. It also can return the total of inventories that have that film in that store.
Internally, it has 2 "queries":
	The first one, is for showing the different inventory_id.
	The second one, is for return the total of inventories. 
*/

CALL film_in_stock(2, 2, @aaa);
SELECT @aaa;
