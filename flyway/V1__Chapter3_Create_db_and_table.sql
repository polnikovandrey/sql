# $mysql-ctl cli;           # Start the CLI (command line interface)

# Create database with name
CREATE DATABASE soap_shop;
# Select database for use
USE soap_shop;
# Show database currently used
SELECT DATABASE();
# Delete database by name
DROP DATABASE soap_shop;
# Note empty result after deletion of currently used database
SELECT DATABASE();
# List available databases (available to logged user)
SHOW DATABASES;


CREATE DATABASE cats_app;
USE cats_app;
# Create a table with some columns. Note: plural noun recommended for table name.
CREATE TABLE cats
(
    name VARCHAR(100),
    age  INT
);
# Show tables in actual database
SHOW TABLES;
# Show columns of a table
SHOW COLUMNS FROM cats;
# Show columns of a table (another way)
DESC cats;
# Delete table in actual database
DROP TABLE cats;
DROP DATABASE cats_app;

CREATE DATABASE pastry_shop;
SHOW DATABASES;
USE pastry_shop;
SELECT DATABASE();
CREATE TABLE pastries
(
    name     VARCHAR(50),
    quantity INT
);
SHOW TABLES;
SHOW COLUMNS FROM pastries;
DROP TABLE pastries;
DROP DATABASE pastry_shop;
