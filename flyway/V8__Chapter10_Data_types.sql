CREATE DATABASE data_types;
USE data_types;

CREATE TABLE dogs (name CHAR(5), breed VARCHAR(10));
# CHAR - fixed length 0-255. Overflow causes error or is truncated (depends on strict mode settings). Spare chars are filled with spaces.
# Space padding is removed from CHAR when retrieved by default.
# CHAR is faster for fixed length text. Memory usage is the same for each row of CHAR, i.e. CHAR(4) == 4 bytes.
# CHAR usage is significant (as speed optimization) only in a huge databases, for most cases VARCHAR is suitable unless optimization needed.
INSERT INTO dogs (name, breed) VALUES ('bob', 'beagle');
INSERT INTO dogs (name, breed) VALUES ('robby', 'corgi');
# Note: error or warning below (depends on strict mode settings) because name overflows capacity of CHAR(5) name column.
# INSERT INTO dogs (name, breed) VALUES ('Princess Jane', 'retriever');
# Note: error because of breed overflow by default. Could be suppressed with settings strict mode off.
# INSERT INTO dogs (name, breed) VALUES ('jenny', 'Some very long breed name');
SELECT * FROM dogs;

# INT is used for storing whole numbers (number without a fraction).
# DECIMAL is used for storing numbers with a fraction part (decimal point with some numbers after that).
# Usage: someColumn DECIMAL(N, M), where:
# N is the maximum number of digits (precision) (includes digits both before and after decimal point) (1-65),
# M is the number of digits in fraction (scale) (0-30, <= N).
# Example: DECIMAL(5, 2) for 999.99 number.
CREATE TABLE items (price DECIMAL(5, 2));
INSERT INTO items (price) VALUES (7);
# Not a valid value below, number of digits > 5. Error in strict mode, maximum allowed value (999.99) in non strict mode.
# INSERT INTO items (price) VALUES (56456464);
INSERT INTO items (price) VALUES (34.88);
# Note: stored value is rounded to allowed fraction part in case of fraction overflow. The stored value is 299.00.
INSERT INTO items (price) VALUES (298.9999);
# Note: the same rounding takes place, stored value is 2.00.
INSERT INTO items (price) VALUES (1.9999);
SELECT * FROM items;
DROP TABLE dogs;

# Difference between DECIMAL and FLOAT/DOUBLE: DECIMAL is fixed-point type and calculations are exact, FLOAT/DOUBLE are floating-point types and calculations are approximate.
# So FLOAT/DOUBLE use less space/memory and could be used to store larger numbers, BUT at the cost of precision.
# FLOAT uses 4 bytes and has precision issues after ~7 digits. DOUBLE uses 8 bytes and has precision issues after ~15 digits.
# Generally, FLOAT/DOUBLE values are good for scientific Calculations, but should not be used for Financial/Monetary Values. For Business Oriented Math, always use DECIMAL.
# A precision from 0 to 23 results in a 4-byte single-precision FLOAT column. A precision from 24 to 53 results in an 8-byte double-precision DOUBLE column.
# For maximum portability, code requiring storage of approximate numeric data values should use FLOAT or DOUBLE PRECISION with no specification of precision or number of digits.
# Note: 38 is the maximum number of digits for DECIMAL.
CREATE TABLE decimals_precision (num_decimal DECIMAL(38, 18), num_second FLOAT, num_third DOUBLE);
INSERT INTO decimals_precision (num_decimal, num_second, num_third) VALUES (123456, 123456, 123456);
INSERT INTO decimals_precision (num_decimal, num_second, num_third) VALUES (1234567, 1234567, 1234567);
INSERT INTO decimals_precision (num_decimal, num_second, num_third) VALUES (123456789, 123456789, 123456789);
INSERT INTO decimals_precision (num_decimal, num_second, num_third) VALUES (123456789.123456789, 123456789.123456789, 123456789.123456789);
INSERT INTO decimals_precision (num_decimal, num_second, num_third) VALUES (1234567890123456789, 1234567890123456789, 1234567890123456789);
INSERT INTO decimals_precision (num_decimal, num_second, num_third)
VALUES (1234567890123456789.1234567890123456789, 1234567890123456789.1234567890123456789, 1234567890123456789.1234567890123456789);
SELECT * FROM decimals_precision;
DROP TABLE decimals_precision;

# DATE type stores date wo time, "YYYY-MM-DD" format.
# TIME type stores time wo date, "HH:MM:SS" format.
# DATETIME type stores both date and time, "YYYY-MM-DD HH:MM:SS" format.
CREATE TABLE people(name VARCHAR(100), birthdate DATE, birthtime TIME, birthboth DATETIME);
INSERT INTO people (name, birthdate, birthtime, birthboth)
 VALUES ('Padma', '1989-12-30', '18:17:30', '1989-12-30 18:17:30'),
        ('Larry', '1985-10-24', '20:45:15', '1985-10-24 20:45:15');

# CURDATE() function returns current date wo time.
SELECT CURDATE();
# CURTIME() function returns current time wo date.
SELECT CURTIME();
# NOW() function returns both date and time.
SELECT NOW();
INSERT INTO people (name, birthdate, birthtime, birthboth)
VALUES ('Henry', CURDATE(), CURTIME(), NOW());
SELECT * FROM people;

# DAY() DD; DAYOFMONTH() synonym to DAY() DD; DAYNAME() Friday; WEEKDAY() 0-Monday 0-6; DAYOFWEEK() 1-Sunday 1-7; DAYOFYEAR() 365.
SELECT name, DAY(birthdate), DAYOFMONTH(birthdate), DAYNAME(birthdate), WEEKDAY(birthdate), DAYOFWEEK(birthdate), DAYOFYEAR(birthdate) FROM people;
# MONTH() 1-12, MONTHNAME() May
SELECT name, MONTH(birthdate), MONTHNAME(birthdate) FROM people;
# HOUR(), MINUTE(), SECOND()
SELECT name, HOUR(birthtime), MINUTE(birthtime), SECOND(birthtime) FROM people;
SELECT name, CONCAT(MONTHNAME(birthboth), ' ', DAY(birthboth), ' ', YEAR(birthboth)) as 'Date of birth' FROM people;
# DATE_FORMAT() - convenient way to format dates wo CONCAT(). Note: result is the same as of previous query.
SELECT name, DATE_FORMAT(birthboth, '%M %d %Y') FROM people;
SELECT DATE_FORMAT('1981-06-20 08:15:05', 'Was born on %M %d %Y');

# DATEDIFF(date1, date2) calculates signed days difference between two dates (time is ignored).
SELECT DATEDIFF('1981-06-20 08:15:05', NOW());
# DATE_ADD(date, INTERVAL expr unit), DATE_SUB(date, INTERVAL expr unit). Note: INTERVAL could be used in arithmetic-like expressions (+-).
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);
SELECT NOW() - INTERVAL 1 DAY + INTERVAL 2 HOUR;
DROP TABLE people;

# TIMESTAMP type is like DATETIME. They differ in memory usage - 8 bytes for DATETIME vs 4 bytes for TIMESTAMP. Also, they differ in ranges:
# DATETIME '1000-01-01 00:00:00' - '9999-12-31 23;59:59'
# TIMESTAMP '1970-01-01 00:00:01'UTC - '2038-01-19 03:14:07'UTC
# TIMESTAMP is basically used for storing unmodified date of creation, see example below.
CREATE TABLE comments (
    content VARCHAR(100),
    created TIMESTAMP DEFAULT NOW()
);
INSERT INTO comments (content) VALUES ('Content1'), ('Content2'), ('Content3');
# TIMESTAMP values are the same in this particular example (single query).
SELECT created FROM comments;
DROP TABLE comments;
# Note: ON UPDATE CURRENT_TIMESTAMP means that UPDATE query will modify TIMESTAMP value to NOW() automatically. CURRENT_TIMESTAMP is same as NOW(), so NOW() could be used instead.
CREATE TABLE comments2 (
    content VARCHAR(100),
    changed TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
);
INSERT INTO comments2 (content) VALUES ('Content1'), ('Content2'), ('Content3');
UPDATE comments2 SET content='Content1 modified' WHERE content='Content1';
SELECT changed FROM comments2 WHERE content='Content1 modified';
DROP TABLE comments2;

# Current time
SELECT CURTIME();
# Current date
SELECT CURDATE();
# Current day of week (number)
SELECT DAYOFWEEK(NOW());
# Current day of week (name)
SELECT DAYNAME(NOW());
# Current day in format mm/dd/yyyy
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');
# Current date in format "January 2nd at 3:15"
SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');
# Tweets table
CREATE TABLE tweets (
    content VARCHAR(140),
    username VARCHAR(100),
    created TIMESTAMP DEFAULT NOW());
INSERT INTO tweets (content, username) VALUES ('Tweet content', 'Polni');
SELECT * FROM tweets;
DROP TABLE tweets;
DROP DATABASE data_types;


