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
# Below are string comparisons. It's suggested to avoid such comparisons and use alternative methods.
# Result is 0
SELECT 'a' > 'b';
# Note: Uppercase and lowercase strings are equal in MySQL by default.
# Result is 0. Depends on settings.
SELECT 'A' > 'a';
# Result is 1.
SELECT 'A' >= 'a';

# < means Less Than, <= means Less Than Or Equal To.
SELECT * FROM books WHERE released_year < 2000;
SELECT * FROM books WHERE released_year <= 2000;
SELECT * FROM books WHERE stock_quantity <= 100;

# AND operator means Logical And.
# Note: && could be used, but is deprecated. AND operator should be used instead.
SELECT * FROM books WHERE author_lname='Eggers' AND released_year > 2010 AND title LIKE '%novel%';

# OR operator means Logical Or.
SELECT * FROM books WHERE author_lname='Eggers' OR released_year > 2010 OR stock_quantity > 100;

# BETWEEN operator allows to select values between two provided values (inclusive).
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

# IN and NOT IN are used to check existence/absence of a value in a set of values.
USE book_shop;
SELECT * FROM books WHERE author_lname = 'Carver' OR author_lname = 'Lahiri' OR author_lname = 'Smith';
# The same with IN.
SELECT * FROM books WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
SELECT * FROM books WHERE released_year IN (2017, 1985);
SELECT * FROM books WHERE released_year NOT IN (2017, 1985);

# % - modulo operator, aka reminder operator.
# Select books with even released years only.
SELECT * FROM books WHERE released_year % 2 = 0;

# CASE statements allow to make decisions.
# Calculate books release year century.
SELECT title, released_year,
       CASE
           WHEN released_year > 1999 THEN 'XXI'
           ELSE 'XX' END
           AS century
FROM books;
# Calculate books stock quantity rating.
SELECT title, stock_quantity,
       CASE
           WHEN stock_quantity > 100 THEN '***'
           WHEN stock_quantity > 50 THEN '**'
           ELSE '*' END
           AS stock_rating
FROM books;

SELECT * FROM books WHERE released_year < 1980;
SELECT * FROM books WHERE author_lname IN ('Eggers', 'Chabon');
SELECT * FROM books WHERE author_lname = 'Lahiri' AND released_year > 2000;
SELECT * FROM books WHERE pages BETWEEN 100 AND 200;
SELECT * FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';
SELECT * FROM books WHERE SUBSTRING(author_lname, 1, 1) IN ('C', 'S');
SELECT title, author_lname,
       CASE
           WHEN title LIKE '%stories%' THEN 'Short stories'
           WHEN title IN ('Just Kiks', 'A Heartbreaking Work') THEN 'Memoir'
           ELSE 'Novel' END
           AS TYPE
FROM books;
SELECT author_lname, author_fname,
       CASE
           WHEN COUNT(*) > 1 THEN CONCAT(COUNT(*), ' books')
           ELSE CONCAT(COUNT(*), ' book') END
           AS COUNT FROM books GROUP BY author_lname, author_fname;

DROP TABLE books;
DROP DATABASE book_shop;

USE data_types;
DROP TABLE people;
DROP DATABASE data_types;