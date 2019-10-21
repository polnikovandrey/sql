CREATE DATABASE cats_app;
USE cats_app;
CREATE TABLE cats
(
    cat_id INT NOT NULL AUTO_INCREMENT,
    name   VARCHAR(100),
    breed  VARCHAR(100),
    age    INT,
    PRIMARY KEY (cat_id)
);
INSERT INTO cats(name, breed, age)
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);

# Select all data within table (all rows and columns).
SELECT *
FROM cats;
# Select all rows and particular columns. The order of resulting columns corresponds to the order of columns provided in select statement.
SELECT name, age
FROM cats;
# Select all columns and particular rows (matching the WHERE expression).
SELECT *
FROM cats
WHERE age = 4;
# The same as previous, but WHERE expression contains text data.
SELECT *
FROM cats
WHERE name = 'Cindy';
# The same as previous, but WHERE expression text query is uppercase. Note: by default queries are case insensitive.
SELECT *
FROM cats
WHERE name = 'CINDY';
# Just some other examples, nothing special.
SELECT cat_id
FROM cats;
SELECT name, breed
FROM cats;
SELECT name, age
FROM cats
WHERE breed = 'Tabby';
SELECT cat_id, age
FROM cats
WHERE cat_id = age;
# Note the usage of alias AS operator. It's used for "relabeling" (cat_id -> id) query result column names.
# Note: bug exists, which disable column renaming with aliases. MySql Connector/J specific.
SELECT cat_id AS id, name
FROM cats;
SELECT name AS "cat_name", breed AS "kitty_breed"
FROM cats;

SELECT cat_id, name, breed FROM cats WHERE breed='Tabby';
UPDATE cats SET breed='Shorthair' WHERE breed='Tabby';
SELECT cat_id, name, breed FROM cats WHERE breed='Tabby';
SELECT cat_id, name, breed FROM cats WHERE breed='Shorthair';

SELECT name, age FROM cats WHERE name='Misty';
UPDATE cats SET age=14 WHERE name='Misty';
SELECT name, age FROM cats WHERE name='Misty';

SELECT cat_id, name FROM cats WHERE name='Jackson';
UPDATE cats SET name='Jack' WHERE name='Jackson';
SELECT cat_id, name FROM cats WHERE name='Jackson';
SELECT cat_id, name FROM cats WHERE name='Jack';

SELECT cat_id, name, breed FROM cats WHERE name='Ringo';
UPDATE cats SET breed='British Shorthair' WHERE name='Ringo';
SELECT cat_id, name, breed FROM cats WHERE name='Ringo';

SELECT cat_id, breed, age FROM cats WHERE breed='Maine Coon';
UPDATE cats SET age=12 WHERE breed='Maine Coon';
SELECT cat_id, breed, age FROM cats WHERE breed='Maine Coon';

SELECT cat_id, breed FROM cats;
# Note: UPDATE without WHERE updates every row in table.
# noinspection SqlWithoutWhere
UPDATE cats SET breed='Unknown';
SELECT cat_id, breed FROM cats;

SELECT * FROM cats WHERE name='Egg';
DELETE FROM cats WHERE name='Egg';
SELECT * FROM cats WHERE name='Egg';

SELECT cat_id, name, age FROM cats WHERE age=4;
DELETE FROM cats WHERE age=4;
SELECT cat_id, name, age FROM cats WHERE age=4;

SELECT cat_id, name, age FROM cats WHERE age=cat_id;
DELETE FROM cats WHERE age=cat_id;
SELECT cat_id, name, age FROM cats WHERE age=cat_id;

SELECT * FROM cats;
# Note: DELETE without WHERE deletes all rows in table.
# noinspection SqlWithoutWhere
DELETE FROM cats;
SELECT * FROM cats;

DROP TABLE cats;
DROP DATABASE cats_app;