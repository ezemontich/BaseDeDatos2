

CREATE TABLE
    `employees` (
        `employeeNumber` int(11) NOT NULL,
        `lastName` varchar(50) NOT NULL,
        `firstName` varchar(50) NOT NULL,
        `extension` varchar(10) NOT NULL,
        `email` varchar(100) NOT NULL,
        `officeCode` varchar(10) NOT NULL,
        `reportsTo` int(11) DEFAULT NULL,
        `jobTitle` varchar(50) NOT NULL,
        PRIMARY KEY (`employeeNumber`)
    );

insert into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`)
values  (1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),
		(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),
		(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing');


CREATE TABLE
    employees_audit (
        id INT AUTO_INCREMENT PRIMARY KEY,
        employeeNumber INT NOT NULL,
        lastname VARCHAR(50) NOT NULL,
        changedat DATETIME DEFAULT NULL,
        action VARCHAR(50) DEFAULT NULL
    );

INSERT into employees(employeeNumber,lastName,firstName,extension,email,officecode,reportsTo,jobTitle)
VALUES (1,'Facundo','Giordano','asd',NULL,'1',1002,'Worker');

#------#

UPDATE employees set employeeNumber = employeeNumber - 20;
UPDATE employees set employeeNumber = employeeNumber + 20;
SELECT * FROM employees;

#------#

ALTER TABLE employees ADD age int CHECK(age >= 16 AND age <= 70);
ALTER TABLE employees DROP age;

INSERT into employees(employeeNumber,lastName,firstName,extension,email,officecode,reportsTo,jobTitle,age)
VALUES (2,'Juan','Perez','b','JuanGmail','1',1002,'Worker',1);

DELETE FROM employees WHERE employeeNumber = 2;


#------#

ALTER TABLE employees ADD COLUMN lastUpdate TIMESTAMP;
ALTER TABLE employees ADD COLUMN lastUpdateUser VARCHAR(255);

DELIMITER $$
CREATE Trigger before_employee_update BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
SET NEW.lastUpdate = CURRENT_TIMESTAMP;
SET NEW.lastUpdateUser = CURRENT_USER;
END$$
DELIMITER;

#------#

show TRIGGERS from SAKILA;
UPDATE employees SET age = 15 WHERE employeeNumber = 2;
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END

BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    then UPDATE film_text SET title=new.title,
                description=new.description,
                film_id=new.film_id WHERE film_id=old.film_id;
  END
  BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END
