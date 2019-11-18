USE book_shop;
SELECT * FROM books;
# != means not equal.
SELECT title FROM books WHERE released_year != 2017;
SELECT title, author_lname FROM books WHERE author_lname != 'Harris';

# NOT LIKE is opposite to LIKE - select not matching patterns.
SELECT title FROM books WHERE title NOT LIKE 'W%';

# > means Greater Than, >= means Greater Than Or Equal To.
SELECT * FROM books WHERE released_year > 2000;
SELECT * FROM books WHERE released_year >= 2000;
SELECT * FROM books WHERE stock_quantity >= 100;
# Note: below statement reaults in 1 (means true).
SELECT 99 > 1;
# Note: below statement reaults in 0 (means false).
SELECT 1 > 99;
# Below are string comparisons. It's suggested to avoid such comparisons using alternative methods.
# Result is 0
SELECT 'a' > 'b';
# Note: Uppercase and lowercase strings are equal in MySQL by default.
# Result is 0.
SELECT 'A' > 'a';
# Result is 1.
SELECT 'A' >= 'a';

# < means Less Than, <= means Less Than Or Equal To.
SELECT * FROM books WHERE released_year < 2000;
SELECT * FROM books WHERE released_year <= 2000;
SELECT * FROM books WHERE stock_quantity <= 100;

# AND operator means Logical And.
# Note: && could be used, but is deprecated. AND operator should be used.
SELECT * FROM books WHERE author_lname='Eggers' AND released_year > 2010 AND title LIKE '%novel%';

# OR operator means Logical Or.
SELECT * FROM books WHERE author_lname='Eggers' OR released_year > 2010 OR stock_quantity > 100;

# BETWEEN operator allows to select values between two supported (inclusive).
SELECT * FROM books WHERE released_year >= 2004 AND released_year <= 2015;
SELECT * FROM books WHERE released_year BETWEEN 2004 AND 2015;
SELECT * FROM books WHERE released_year NOT BETWEEN 2004 AND 2015;

# When comparing dates and times it's suggested to use CAST() to explicitly convert values to desired data types.
# For example - when comparing DATE and DATETIME the first (DATE) should be converted to DATETIME. String-date/time should be converted to a proper DATE/TIME-type too.
# MySql could define string-date/time type implicitly, but that is a good practice to cast explicitly.
SELECT CAST('2017-05-02' AS DATE);
SELECT CAST('2017-05-02' AS DATETIME);
SELECT CAST('2017-05-02 22:45:16' AS DATETIME);
USE data_types;
# Legal, but not recommended.
SELECT * FROM people WHERE birthdate BETWEEN '1980-01-01' AND '2000-01-01';
# Right way to select between dates (with cast).
SELECT * FROM people WHERE birthdate BETWEEN CAST('1980-01-01' AS DATE) AND CAST('2000-01-01' AS DATE);


DROP TABLE people;
DROP DATABASE data_types;