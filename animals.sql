DROP DATABASE IF EXISTS human_friends;
CREATE DATABASE human_friends;
USE human_friends;

CREATE TABLE pets
(
	id SERIAL KEY,
	name VARCHAR(50),
	birthday DATETIME,
	type VARCHAR(50)
);

CREATE TABLE pack_animals
(
	id SERIAL KEY,
	name VARCHAR(50),
	birthday DATETIME,
	type VARCHAR(50)
);

CREATE TABLE commands
(
	id SERIAL KEY,
	value VARCHAR(50)
);

CREATE TABLE pets_commands
(
	id SERIAL KEY,
	pet_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (pet_id) REFERENCES pets(id)
		ON DELETE CASCADE
    	ON UPDATE CASCADE,
	command_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (command_id) REFERENCES commands(id)
		ON DELETE CASCADE
    	ON UPDATE CASCADE
);

CREATE TABLE pack_animals_commands
(
	id SERIAL KEY,
	pack_animal_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (pack_animal_id) REFERENCES pack_animals(id)
		ON DELETE CASCADE
    	ON UPDATE CASCADE,
	command_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (command_id) REFERENCES commands(id)
		ON DELETE CASCADE
    	ON UPDATE CASCADE
);

INSERT INTO commands(value) VALUES('Sit');
INSERT INTO commands(value) VALUES('Stay');
INSERT INTO commands(value) VALUES('Fetch');
INSERT INTO commands(value) VALUES('Pounce');
INSERT INTO commands(value) VALUES('Roll');
INSERT INTO commands(value) VALUES('Hide');
INSERT INTO commands(value) VALUES('Paw');
INSERT INTO commands(value) VALUES('Bark');
INSERT INTO commands(value) VALUES('Scratch');
INSERT INTO commands(value) VALUES('Spin');
INSERT INTO commands(value) VALUES('Meow');
INSERT INTO commands(value) VALUES('Jump');
INSERT INTO commands(value) VALUES('Trot');
INSERT INTO commands(value) VALUES('Canter');
INSERT INTO commands(value) VALUES('Gallop');
INSERT INTO commands(value) VALUES('Walk');
INSERT INTO commands(value) VALUES('Carry Load');
INSERT INTO commands(value) VALUES('Bray');
INSERT INTO commands(value) VALUES('Kick');
INSERT INTO commands(value) VALUES('Run');

INSERT INTO pets(name, birthday, type) VALUES('Whiskey', '2015-07-07', 'Cat');
INSERT INTO pets(name, birthday, type) VALUES('Doggy', '2019-01-01', 'Dog');
INSERT INTO pets(name, birthday, type) VALUES('Hammy', '2023-12-31', 'Hamster');

INSERT INTO pack_animals(name, birthday, type) VALUES('Rookie', '2013-02-05', 'Horse');
INSERT INTO pack_animals(name, birthday, type) VALUES('Lulu', '2024-01-05', 'Camel');
INSERT INTO pack_animals(name, birthday, type) VALUES('Boney', '2022-12-12', 'Donkey');

INSERT INTO pets_commands(pet_id, command_id) VALUES(1, 10);
INSERT INTO pets_commands(pet_id, command_id) VALUES(1, 11);
INSERT INTO pets_commands(pet_id, command_id) VALUES(2, 7);
INSERT INTO pets_commands(pet_id, command_id) VALUES(3, 5);

INSERT INTO pack_animals_commands(pack_animal_id, command_id) VALUES(1, 12);
INSERT INTO pack_animals_commands(pack_animal_id, command_id) VALUES(2, 16);
INSERT INTO pack_animals_commands(pack_animal_id, command_id) VALUES(3, 17);


DELETE FROM pack_animals WHERE type = 'Camel';

CREATE TABLE animals_one_to_three_years_old
(
	id SERIAL KEY,
	name VARCHAR(50),
	birthday DATETIME,
	type VARCHAR(50),
	months INT
);

INSERT INTO animals_one_to_three_years_old
(name, birthday, type, months)
SELECT name, birthday, type,
PERIOD_DIFF(DATE_FORMAT(CURRENT_DATE(), '%y%m'), DATE_FORMAT(birthday, '%y%m')) AS months
FROM pack_animals
WHERE (DATEDIFF(CURRENT_DATE(), birthday) / 365) BETWEEN 1 AND 3;

INSERT INTO animals_one_to_three_years_old
(name, birthday, type, months)
SELECT name, birthday, type,
PERIOD_DIFF(DATE_FORMAT(CURRENT_DATE(), '%y%m'), DATE_FORMAT(birthday, '%y%m')) AS months
FROM pets
WHERE (DATEDIFF(CURRENT_DATE(), birthday) / 365) BETWEEN 1 AND 3;

SELECT p.*, c.value AS command FROM pets p
LEFT JOIN pets_commands pc ON p.id = pc.pet_id
LEFT JOIN commands c ON c.id = pc.command_id
UNION ALL
SELECT pa.*, c.value AS command FROM pack_animals pa
LEFT JOIN pack_animals_commands pac ON pa.id = pac.pack_animal_id
LEFT JOIN commands c ON c.id = pac.command_id;