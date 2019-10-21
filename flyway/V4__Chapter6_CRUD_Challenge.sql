CREATE DATABASE shirts_db;
USE shirts_db;
CREATE TABLE shirts (
    shirt_id INT NOT NULL AUTO_INCREMENT,
    article VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    shirt_size VARCHAR(255) NOT NULL,
    last_worn INT NOT NULL,
    PRIMARY KEY (shirt_id)
);
DESC shirts;
INSERT INTO shirts(article, color, shirt_size, last_worn) VALUES
    ('t-shirt', 'white', 'S', 10),
    ('t-shirt', 'green', 'S', 200),
    ('polo shirt', 'black', 'M', 10),
    ('tank top', 'blue', 'S', 50),
    ('t-shirt', 'pink', 'S', 0),
    ('polo shirt', 'red', 'M', 5),
    ('tank top', 'white', 'S', 200),
    ('tank top', 'blue', 'M', 15);
INSERT INTO shirts(article, color, shirt_size, last_worn) VALUES
    ('polo shirt', 'purple', 'M', 50);
SELECT * FROM shirts;

SELECT article, color FROM shirts;

SELECT article, color, shirt_size, last_worn FROM shirts WHERE shirt_size='M';

SELECT article, shirt_size FROM shirts WHERE article='polo shirt';
UPDATE shirts SET shirt_size='L' WHERE article='polo shirt';
SELECT article, shirt_size FROM shirts WHERE article='polo shirt';

SELECT shirt_id, last_worn FROM shirts WHERE last_worn=15;
UPDATE shirts SET last_worn=0 WHERE last_worn=15;
SELECT shirt_id, last_worn FROM shirts WHERE last_worn=15;

SELECT shirt_id, shirt_size, color FROM shirts WHERE color='white';
UPDATE shirts SET shirt_size='XS', color='off white' WHERE color='white';
SELECT shirt_id, shirt_size, color FROM shirts WHERE color='white';
SELECT shirt_id, shirt_size, color FROM shirts WHERE color='off white';

SELECT shirt_id, last_worn FROM shirts WHERE last_worn=200;
DELETE FROM shirts WHERE last_worn=200;
SELECT shirt_id, last_worn FROM shirts WHERE last_worn=200;

SELECT shirt_id, article FROM shirts WHERE article='tank top';
DELETE FROM shirts WHERE article='tank top';
SELECT shirt_id, article FROM shirts WHERE article='tank top';

SELECT * FROM shirts;
# noinspection SqlWithoutWhere
DELETE FROM shirts;
SELECT * FROM shirts;

DROP TABLE shirts;
DROP DATABASE shirts_db;