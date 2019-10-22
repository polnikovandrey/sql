DROP DATABASE IF EXISTS book_shop;
CREATE DATABASE book_shop;
USE book_shop;
CREATE TABLE books
(
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100),
    author_fname VARCHAR(100),
    author_lname VARCHAR(100),
    released_year INT,
    stock_quantity INT,
    pages INT,
    PRIMARY KEY(book_id)
);
# Note: use '' to escape single quote (').
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
('Where I''m Calling From: Selected Stories', 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

# Note: CONCAT() takes arbitrary number of arguments.
SELECT CONCAT('Hello', ' a beautiful', ' world', '!');
# Note column name output without AS
SELECT CONCAT(author_fname, ' ', author_lname) FROM books;
# Note column name output with AS
SELECT author_fname AS first, author_lname AS last, CONCAT(author_fname, ' ', author_lname) AS first_last FROM books;
# Note CONCAT_WS - "With Separators"
SELECT CONCAT_WS(' - ', author_lname, author_fname, title) AS 'dash separated' FROM books;

# Note: in MySql string index starts with 1. Result = 'Hello'.
SELECT SUBSTRING('Hello World!', 1, 5);
# Result = 'World!';
SELECT SUBSTRING('Hello World!', 7);
# Result = 'rld!'.
SELECT SUBSTRING('Hello World!', -4);
# Result = '' because string index is 1 based.
SELECT SUBSTRING('Hello World!', 0);
SELECT SUBSTRING(title, 1, 10) AS 'short title' FROM books;
# Note: SUBSTRING and SUBSTR are synonyms.
SELECT SUBSTR(title, 1, 10) AS 'short title' FROM books;
# Note: CONCAT-SUBSTRING combination.
SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS 'short title' FROM books;

# Result = 'o World!'.
SELECT REPLACE('Hello World!', 'Hell', '');
# Result = 'He77o Wor7d!'.
SELECT REPLACE('Hello World!', 'l', '7');
# Note: REPLACE is case sensitive. Result = 'Hello World!' (not changed), because there is no lowercase 'hello'.
SELECT REPLACE('Hello World!', 'hell', '');
SELECT REPLACE(title, 'e', '3') FROM books;
# Note SUBSTRING-REPLACE combination.
SELECT SUBSTRING(REPLACE(title, 'e', '3'), 1, 10) FROM books;

# Result = '!dlroW olleH'
SELECT REVERSE('Hello World!');
SELECT REVERSE(author_fname) FROM books;

# Result = 12
SELECT CHAR_LENGTH('Hello World!');
SELECT author_lname, CHAR_LENGTH(author_lname) AS 'Last name length' FROM books;
SELECT CONCAT(author_lname, ' is ', CHAR_LENGTH(author_lname), ' characters long') FROM books;

# Result = 'HELLO WORLD!'.
SELECT UPPER('Hello World!');
# Result = 'hello world!'.
SELECT LOWER('Hello World!');

SELECT REVERSE(UPPER('Why does my cat look at me with such hatred?'));
SELECT REPLACE(title, ' ', '->') AS title FROM books;
# Note: SUBSTRING(..., 1) usage for correct AS functioning.
SELECT SUBSTRING(author_fname, 1) AS forwards, REVERSE(author_lname) AS backwards FROM books;
SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps' FROM books;
SELECT CONCAT(title, ' was released in ', released_year) AS 'blurb' FROM books;
SELECT title, CHAR_LENGTH(title) as 'character count' FROM books;
SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS 'short title', CONCAT(author_fname, ',', author_lname) AS author, CONCAT(stock_quantity, ' in stock') AS quantity FROM books;