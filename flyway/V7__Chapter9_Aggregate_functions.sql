USE book_shop;

SELECT COUNT(*) FROM books;
SELECT author_fname, author_lname FROM books;
# Note: count includes duplicated author_fname values
SELECT COUNT(author_fname) FROM books;
# Note: now count includes unique values only
SELECT COUNT(DISTINCT author_fname) FROM books;
SELECT COUNT(DISTINCT author_lname) FROM books;
# Note: now count includes unique values both for author_fname AND author_lname (persons with unique first and last names)
SELECT COUNT(DISTINCT author_fname, author_lname) FROM books;
SELECT title FROM books;
SELECT title FROM books WHERE title LIKE '%the%';
SELECT COUNT(DISTINCT title) FROM books WHERE title LIKE '%the%';

# Temporarily overriding sql_mode to support partial grouping (to prevent "this is incompatible with sql_mode=only_full_group_by" error)
SELECT @@session.sql_mode;
SET @sql_mode_value = @@session.sql_mode;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

# Regular select output
SELECT title, author_fname, author_lname FROM books;
# Output grouped by author_fname and author_lname (unique name pairs and first titles per author are printed, but in fact titles are grouped by authors behind the scenes).
SELECT title, author_fname, author_lname FROM books GROUP BY author_fname, author_lname;
# Count books written by authors. It's better to think that data is first grouped by name pairs, then select is applied to each group. So number of rows in group is counted.
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_fname, author_lname;
# Count books released per year.
SELECT released_year, COUNT(*) FROM books GROUP BY released_year ORDER BY released_year;
SELECT CONCAT('In year ', released_year, ' ', COUNT(*), ' books released.') AS 'Books per year' FROM books GROUP BY released_year ORDER BY released_year;

SELECT MIN(released_year) AS 'Earliest release year' FROM books;
SELECT MAX(pages) AS 'Maximim pages number' FROM books;
# Prints title of book with maximum number of pages. Subquery is used to calculate maximum number of pages. Subquery is executed first and the result is used by query.
# Note: when using subqueries one must know that actually multiple queries are executed, so it may be slow on a large dataset.
SELECT title FROM books WHERE pages=(SELECT MAX(pages) FROM books);
# The same as previous, but without using subquery. Supposedly should be faster then the previous query.
SELECT title FROM books GROUP BY pages ORDER BY pages DESC LIMIT 1;
# Calculate earliest release year per author.
SELECT author_lname, author_fname, MIN(released_year) FROM books GROUP BY author_lname, author_fname;
# Calculate the longest page count per author.
SELECT author_lname, author_fname, MAX(pages) FROM books GROUP BY author_lname, author_fname;

# Total pages in table.
SELECT SUM(pages) FROM books;
# Count pages per author.
SELECT author_lname, author_fname, SUM(pages) FROM books GROUP BY author_lname, author_fname;

# Calculates average release year in table. Note: AVG result is not integer, but decimal.
SELECT AVG(released_year) FROM books;
# Average stock quantity for books released same year.
SELECT released_year, AVG(stock_quantity) FROM books GROUP BY released_year;
# Average pages, written by author.
SELECT author_lname, author_fname, AVG(pages) FROM books GROUP BY author_lname, author_fname;

# Number of books in the table.
SELECT COUNT(*) FROM books;
# Books released per year.
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
# Total books in stock.
SELECT SUM(stock_quantity) FROM books;
# Average release year per author.
SELECT author_lname, author_fname, AVG(released_year) FROM books GROUP BY author_lname, author_fname;
# Fullname of the author of the longest book.
SELECT CONCAT(author_fname, ' ', author_lname) FROM books WHERE pages=(SELECT MAX(pages) FROM books);
# The same without subquery.
SELECT CONCAT(author_fname, ' ', author_lname) FROM books ORDER BY pages DESC LIMIT 1;
# Release year, books released, average pages.
SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages' FROM books GROUP BY released_year;

# Restoring sql_mode.
SET sql_mode = @sql_mode_value;