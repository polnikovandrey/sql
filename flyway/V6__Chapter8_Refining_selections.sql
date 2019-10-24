USE book_shop;
INSERT INTO books
(title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256),
       ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
       ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

SELECT author_lname FROM books;
# DISTINCT means unique, so result doesn't contains duplicates
SELECT DISTINCT author_lname FROM books;
# Below is 2 different ways to get distinct full names, note the difference.
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) FROM books;
# This variant selects distinct combinations of first-last names.
SELECT DISTINCT author_fname, author_lname FROM books;

# ORDER BY
SELECT author_lname, author_fname FROM books ORDER BY author_lname, author_fname;
# Alternative ORDER BY with 1-based column indexes. Means order by 2 column first (author_fname), then by 1 column (author_lname).
SELECT author_lname, author_fname FROM books ORDER BY 2, 1;

# ORDER BY ... DESC, LIMIT ROWS_QUANTITY
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 5;
# LIMIT ZERO_BASED_START_ROW, ROWS_QUANTITY
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 3,2;
# Note: official "from docs" way of getting all the data starting from row is to provide a large enough number as ROWS_QUANTITY.
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 3, 18446744073709551615;

# WHERE ... LIKE ... . Note: %some% is looking for strings, containing case insensitive substring 'some' (or 'SoMe') anywhere. % means any number or zero of any symbols.
SELECT title, author_fname FROM books WHERE author_fname LIKE '%da%';
# Look for authors with first name starting with 'da' (or 'dA').
SELECT title, author_fname FROM books WHERE author_fname LIKE 'da%';
# Look for authors with first name ending with 'da' (or 'dA').
SELECT title, author_fname FROM books WHERE author_fname LIKE '%da';
SELECT title FROM books WHERE title LIKE '%the%';
# Note: _ wildcard matches exactly one any symbol. Here looking for books, whose stock_quantity contains exactly 4 symbols (digits here).
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '_____';
# Note: % escaping with '\'. Find all strings, containing '%' symbol;
SELECT title, stock_quantity FROM books WHERE title LIKE '%\%%';
# Note: _ escaping with '\'. Find all strings, containing '_' symbol;
SELECT title, stock_quantity FROM books WHERE title LIKE '%\_%';

SELECT title FROM books WHERE title LIKE '%stories%';
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;
SELECT CONCAT(title, ' - ', released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';
SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity LIMIT 3;
SELECT title, author_lname FROM books ORDER BY author_lname, title;
SELECT CONCAT('MY FAVORITE AUTHOR IS ', author_fname, ' ', author_lname, '!') AS yell FROM books ORDER BY author_lname;