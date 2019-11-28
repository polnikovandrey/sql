# One to one example - AUTHORS table and AUTHORS_DETAIL table. The first contains basic info, the last - detailed (address, date of birth, ...).
# One to many example - BOOKS table and BOOK_REVIEWS table. Book could have many reviews, but a review belongs to exactly one book.
# Many to many example - BOOKS table and AUTHORS table. Book could have multiple authors, author could have written multiple books.

# One to many relationship is usually implemented with two tables. "One" table has an id, "Many" table has both id and foreign id, which points to "One" table record.
# The BAD alternative is to use one huge table with all the data, but there would be numerous duplications and NULLS in such a table.
# Primary key is always and guaranteed unique (by autoincrement) and usually is used to store ids of distinct records (entities) in a table.
# Foreign key is a reference to another table's primary key, so a single pk could be used as a reference multiple times (one- or many-to-many relation).
# Foreign key must be declared in table definition to allow db check relation correctness (to check if according primary key exists). That is one, but not only reason to declare.
CREATE DATABASE customers;
USE customers;
# PRIMARY KEY declaration constraints column data to be unique, but data must be supplied manually. AUTO_INCREMENT forces db to generate unique data automatically.
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);
# FOREIGN KEY constraints column data to refer to existing record in a foreign table.
# The convention for FOREIGN KEY column name is "referenced table name"_"referenced column name".
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);
INSERT INTO customers (first_name, last_name, email)
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);


# Select all orders by Boy George customer using subquery (possible, but INCONVENIENT and SLOW method). Joins could be used to solve the problem the RIGHT way.
SELECT * FROM orders WHERE customer_id = (SELECT id FROM customers WHERE first_name = 'Boy' AND last_name = 'George');

# Cross join (cartesian join). Joins EVERY record with EVERY record of tables provided in a query. So the output is all possible combinations or records. Is rarely used.
SELECT * FROM customers, orders;

# Inner join is used to get ONLY OVERLAPPING data of every table being joined.
# Note: unique column names could be used without prefix, but the convention is to prepend column names with table names and dot when querying multiple tables.
# Implicit inner join = cross join + WHERE condition used to join records of different tables by some criteria.
SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;

# Explicit inner join. CONVENTIONAL way of inner joining. The meaning and result are both the same as previous.
SELECT * FROM customers JOIN orders ON customers.id = orders.customer_id;
# The same query, but the output is a little bit condensed.
# Note: JOIN is the same as INNER JOIN.
SELECT first_name, last_name, amount FROM customers INNER JOIN orders ON customers.id = orders.customer_id;
# The result of previous query could be grouped by customer, calculating the sum of amounts at the same time.
SELECT first_name, last_name, SUM(amount) FROM customers JOIN orders ON customers.id = orders.customer_id GROUP BY customers.id;

# Left join provides joined result row for EVERY record of a first table (FROM query part) with every matching records of a second table (if any).
# So first table's data could meet multiple times in results.
# If no matches are found for a record - it's printed one time with NULLs (or empty value) provided as data for the missing part of a join (settings based behavior).
# In other words - when using left join db cycles through each record of FROM table and prints join result for each match in the second table (or a single record if no matches).
SELECT * FROM customers LEFT JOIN orders ON customers.id = orders.customer_id;
# Query to select every customer and print total amount of orders, including customers without orders.
# Note: customers without orders couldn't be printed using inner join, but it's possible with left join.
SELECT first_name, last_name, SUM(amount) FROM customers LEFT JOIN orders ON customers.id = orders.customer_id GROUP BY customers.id;
# IFNULL() method could be used to replace the value1 with value2 if value1 is NULL, and leave value1 as is otherwise.
SELECT first_name, last_name, IFNULL(SUM(amount), 0) FROM customers LEFT JOIN orders ON customers.id = orders.customer_id GROUP BY customers.id;






# DROP TABLE customers;
# DROP DATABASE customers;