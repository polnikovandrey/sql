CREATE DATABASE cats_app;
USE cats_app;
CREATE TABLE cats(name VARCHAR(20), age INT);
DESC cats;
# Note: the order of INSERT query parameters may differ for different queries, but the order in brackets must match for a single query.
INSERT INTO cats(name, age) VALUES ('Mars', 10);
INSERT INTO cats(age, name) VALUES (1, 'Blue');
# Note: Multiple insert
INSERT INTO cats(age, name) VALUES (3, 'Fluffy'), (5, 'Butters'), (8, 'Garfield');
SELECT * FROM cats;

CREATE DATABASE people_app;
USE people_app;
CREATE TABLE people(first_name VARCHAR(20), last_name VARCHAR(20), age INT);
INSERT INTO people(first_name, last_name, age) VALUES ('Andrei', 'Polnikau', 39);
INSERT INTO people(last_name, age, first_name) VALUES ('Polnikava', 38, 'Volha');
INSERT INTO people(first_name, last_name, age) VALUES ('Svetlana', 'Polnikava', 65), ('Danila', 'Polnikau', 4), ('Mars', 'Polnikau', 10);
SELECT * FROM people;

# Need to override sql_mode for Warnings to work as in the course.
SELECT @@session.sql_mode;
SET @sql_mode_value = @@session.sql_mode;
SET SQL_MODE = '';

USE cats_app;
INSERT INTO cats(name, age) VALUES ('Incorrect age type', 'blah blah');
SHOW WARNINGS;
INSERT INTO cats(name, age) VALUES ('VARCHAR(20) overflow VARCHAR(20) overflow VARCHAR(20) overflow ', 1);
SHOW WARNINGS;
INSERT INTO cats(name, age) VALUES ('VARCHAR(20) overflow VARCHAR(20) overflow VARCHAR(20) overflow ', 1);
INSERT INTO cats(name, age) VALUES ('Snuffer', 10);
# Note: warnings are shown straight after incorrect query only. So next query shows 0 warnings after incorrect query followed by correct one.
SHOW WARNINGS;
SELECT * FROM cats;

# By default values are nullable (Null=YES), so it's ok to skip those values.
INSERT INTO cats (name) VALUES('Kitty');
SHOW WARNINGS;
INSERT INTO cats (age) VALUES(8);
SHOW WARNINGS;
# NULL value is legal here for this table and column.
INSERT INTO cats (name, age) VALUES('Richard', NULL);
SELECT * FROM cats;

## NOT NULL
CREATE TABLE cats_not_nullable(name VARCHAR(20) NOT NULL, age INT NOT NULL);
# Note Null=NO in table description.
DESC cats_not_nullable;
# Skipped NOT NULL values are filled with default values if set, or by mysql-default values if unset (empty VARCHAR, 0 INT, ...)
INSERT INTO cats_not_nullable (name) VALUES('Kitty');
INSERT INTO cats_not_nullable (age) VALUES(9);
# NULL is not allowed for this column, ERROR is thrown.
# INSERT INTO cats_not_nullable (name, age) VALUES('Griffin', NULL);
SELECT * FROM cats_not_nullable;

## DEFAULT and NOT NULL
CREATE TABLE cats_default(name VARCHAR(20) NOT NULL DEFAULT 'Noname', age INT DEFAULT 99);
DESC cats_default;
INSERT INTO cats_default(name) VALUES('Muffin');
INSERT INTO cats_default(age) VALUES(10);
INSERT INTO cats_default(name, age) VALUES('Furious', NULL);
# NULL is not allowed for column age, ERROR is thrown.
# INSERT INTO cats_default(name, age) VALUES(NULL, 3);
SELECT * FROM cats_default;

# Restoring sql_mode.
SET SQL_MODE = @sql_mode_value;
