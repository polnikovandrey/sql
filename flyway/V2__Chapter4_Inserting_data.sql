CREATE DATABASE cats_app;
USE cats_app;
CREATE TABLE cats
(
    name VARCHAR(20),
    age  INT
);
DESC cats;
# Note: the order of INSERT query parameters may differ for different queries, but the order in brackets must match for a single query.
INSERT INTO cats(name, age)
VALUES ('Mars', 10);
INSERT INTO cats(age, name)
VALUES (1, 'Blue');
# Note: Multiple insert
INSERT INTO cats(age, name)
VALUES (3, 'Fluffy'),
       (5, 'Butters'),
       (8, 'Garfield');
SELECT *
FROM cats;

CREATE DATABASE people_app;
USE people_app;
CREATE TABLE people
(
    first_name VARCHAR(20),
    last_name  VARCHAR(20),
    age        INT
);
INSERT INTO people(first_name, last_name, age)
VALUES ('Andrei', 'Polnikau', 39);
INSERT INTO people(last_name, age, first_name)
VALUES ('Polnikava', 38, 'Volha');
INSERT INTO people(first_name, last_name, age)
VALUES ('Svetlana', 'Polnikava', 65),
       ('Danila', 'Polnikau', 4),
       ('Mars', 'Polnikau', 10);
SELECT *
FROM people;
DROP TABLE people;

# Need to override sql_mode for Warnings to work as in the course.
SELECT @@session.sql_mode;
SET @sql_mode_value = @@session.sql_mode;
SET SQL_MODE = '';

USE cats_app;
INSERT INTO cats(name, age)
VALUES ('Incorrect age type', 'blah blah');
SHOW WARNINGS;
INSERT INTO cats(name, age)
VALUES ('VARCHAR(20) overflow VARCHAR(20) overflow VARCHAR(20) overflow ', 1);
SHOW WARNINGS;
INSERT INTO cats(name, age)
VALUES ('VARCHAR(20) overflow VARCHAR(20) overflow VARCHAR(20) overflow ', 1);
INSERT INTO cats(name, age)
VALUES ('Snuffer', 10);
# Note: warnings are shown straight after incorrect query only. So next query shows 0 warnings after incorrect query followed by correct one.
SHOW WARNINGS;
SELECT *
FROM cats;

# By default values are nullable (Null=YES), so it's ok to skip those values.
INSERT INTO cats (name)
VALUES ('Kitty');
SHOW WARNINGS;
INSERT INTO cats (age)
VALUES (8);
SHOW WARNINGS;
# NULL value is legal here for this table and column.
INSERT INTO cats (name, age)
VALUES ('Richard', NULL);
SELECT *
FROM cats;
DROP TABLE cats;

## NOT NULL
CREATE TABLE cats_not_nullable
(
    name VARCHAR(20) NOT NULL,
    age  INT         NOT NULL
);
# Note Null=NO in table description.
DESC cats_not_nullable;
# Skipped NOT NULL values are filled with default values if set, or by mysql-default values if unset (empty VARCHAR, 0 INT, ...)
INSERT INTO cats_not_nullable (name)
VALUES ('Kitty');
INSERT INTO cats_not_nullable (age)
VALUES (9);
# NULL is not allowed for this column, ERROR is thrown.
# INSERT INTO cats_not_nullable (name, age) VALUES('Griffin', NULL);
SELECT *
FROM cats_not_nullable;
DROP TABLE cats_not_nullable;

## DEFAULT and NOT NULL
CREATE TABLE cats_default
(
    name VARCHAR(20) NOT NULL DEFAULT 'Noname',
    age  INT                  DEFAULT 99
);
DESC cats_default;
INSERT INTO cats_default(name)
VALUES ('Muffin');
INSERT INTO cats_default(age)
VALUES (10);
INSERT INTO cats_default(name, age)
VALUES ('Furious', NULL);
# NULL is not allowed for column age, ERROR is thrown.
# INSERT INTO cats_default(name, age) VALUES(NULL, 3);
SELECT *
FROM cats_default;
DROP TABLE cats_default;

# Restoring sql_mode.
SET SQL_MODE = @sql_mode_value;

# Note primary key
CREATE TABLE unique_cats
(
    cat_id INT NOT NULL,
    name   VARCHAR(10),
    age    INT,
    PRIMARY KEY (cat_id)
);
DESC unique_cats;
# Note cat_id manual handling below. It's not practical, but is possible.
INSERT INTO unique_cats(cat_id, name, age)
VALUES (1, 'Fred', 20);
INSERT INTO unique_cats(cat_id, name, age)
VALUES (2, 'Phil', 8);
# Note an error **Duplicate entry '1' for key 'PRIMARY'** due to the cat_id duplication.
# INSERT INTO unique_cats(cat_id, name, age) VALUES(1, 'Not_unique', 12);
SELECT *
FROM unique_cats;
DROP TABLE unique_cats;
# The same table, but no more manual id handling.
CREATE TABLE auto_increment_unique_cats
(
    cat_id INT NOT NULL AUTO_INCREMENT,
    name   VARCHAR(10),
    age    INT,
    PRIMARY KEY (cat_id)
);
DESC auto_increment_unique_cats;
INSERT INTO auto_increment_unique_cats(name, age)
VALUES ('Daisy', 10);
INSERT INTO auto_increment_unique_cats(name, age)
VALUES ('Dolly', 7);
SELECT *
FROM auto_increment_unique_cats;
DROP TABLE auto_increment_unique_cats;
DROP DATABASE cats_app;

CREATE DATABASE work;
USE work;
CREATE TABLE employees
(
    id             INT         NOT NULL AUTO_INCREMENT,
    last_name      VARCHAR(20) NOT NULL,
    first_name     VARCHAR(20) NOT NULL,
    middle_name    VARCHAR(20),
    age            INT         NOT NULL,
    current_status VARCHAR(20) NOT NULL DEFAULT 'employed',
    PRIMARY KEY (id)
);
DESC employees;
INSERT INTO employees(last_name, first_name, middle_name, age, current_status)
VALUES ('Polnikov', 'Andrey', 'Eugenavich', 38, 'learning');
INSERT INTO employees(last_name, first_name, age)
VALUEs ('Smith', 'Don', 70);
SELECT *
FROM employees;
DROP TABLE employees;
# Note another way to define primary key (table is identical to employees).
CREATE TABLE employees_again
(
    id             INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    last_name      VARCHAR(20) NOT NULL,
    first_name     VARCHAR(20) NOT NULL,
    middle_name    VARCHAR(20),
    age            INT         NOT NULL,
    current_status VARCHAR(20) NOT NULL DEFAULT 'employed'
);
DESC employees_again;
DROP TABLE employees_again;
DROP DATABASE work;