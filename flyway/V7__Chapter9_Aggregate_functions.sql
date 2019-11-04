USE book_shop;
SELECT COUNT(*) FROM books;
SELECT author_fname FROM books;
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
