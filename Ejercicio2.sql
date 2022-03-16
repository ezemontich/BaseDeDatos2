CREATE TABLE film (
	film_id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(30), 
	description VARCHAR(40), 
	release_year DATE, 
	PRIMARY KEY(film_id)
);

CREATE TABLE actor (
	actor_id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(20),
	last_name VARCHAR(30), 
	PRIMARY KEY(actor_id)
);

CREATE TABLE film_actor (
	film_id INT NOT NULL, 
	actor_id INT NOT NULL
);

#----#

ALTER TABLE film 
	ADD COLUMN last_update TIMESTAMP 
		DEFAULT CURRENT_TIMESTAMP 
		ON UPDATE CURRENT_TIMESTAMP
;

ALTER TABLE actor
	ADD COLUMN last_update TIMESTAMP 
		DEFAULT CURRENT_TIMESTAMP 
		ON UPDATE CURRENT_TIMESTAMP
;

#----#
	
ALTER TABLE film_actor 
	ADD FOREIGN KEY (film_id) REFERENCES film(film_id), 
	ADD FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
;

#----#

INSERT INTO film (title, description, release_year) VALUES 
	('Star Wars', 'Descripcion de Star Wars', '1977-01-01'), 
	('Indiana Jones', 'Descripcion de Indiana Jones', '1989-02-02'),
	('Colateral', 'Descripcion de Colateral', '2004-03-03'),
	('Top Gun', 'Descripcion de Top Gun', '1986-04-04')
;

INSERT INTO actor (first_name, last_name) VALUES 
	('Harrison', 'Ford'),
	('Mark', 'Hamill'),
	('Sean', 'Connery'),
	('Tom', 'Cruise'),
	('Jamie', 'Foxx'),
	('Mark', 'Ruffalo')
;

INSERT INTO film_actor VALUES
	(1, 1),
	(1, 2),
	(2, 1),
	(2, 3),
	(3, 4),
	(3, 5),
	(3, 6),
	(4, 4)
;
