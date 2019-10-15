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
SELECT cat_id AS id, name
FROM cats;
SELECT name AS 'cat name', breed AS 'kitty breed'
FROM cats;



DROP TABLE cats;
DROP DATABASE cats_app;