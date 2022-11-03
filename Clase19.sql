CREATE USER data_analyst IDENTIFIED BY 'password';
SELECT user, host FROM mysql.user;

#-----#

SHOW GRANTS FOR 'data_analyst'@'%';
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'%';

#-----#

CREATE TABLE test(
    test_id INT(11) NOT NULL AUTO_INCREMENT);
-- ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'test'

#-----#

SELECT * FROM film LIMIT 10;

UPDATE film SET title = 'Relatos Salvajes' WHERE film_id = 10;

SELECT * FROM film LIMIT 10;

#-----#

SHOW GRANTS FOR 'data_analyst'@'%';

REVOKE UPDATE ON sakila.* FROM data_analyst;

SHOW GRANTS FOR 'data_analyst'@'%';

#-----#

SELECT * FROM film LIMIT 10;

UPDATE film SET title = 'Misterio a Bordo' WHERE film_id = 10;
-- ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'

UPDATE film SET title = 'Pelicula' WHERE film_id = 20;
-- ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
