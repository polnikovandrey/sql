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
INSERT INTO decimals_precision (num_decimal, num_second, num_third)VALUES (123456, 123456, 123456);
INSERT INTO decimals_precision (num_decimal, num_second, num_third)VALUES (1234567, 1234567, 1234567);
INSERT INTO decimals_precision (num_decimal, num_second, num_third)VALUES (123456789, 123456789, 123456789);
INSERT INTO decimals_precision (num_decimal, num_second, num_third)VALUES (123456789.123456789, 123456789.123456789, 123456789.123456789);
INSERT INTO decimals_precision (num_decimal, num_second, num_third)VALUES (1234567890123456789, 1234567890123456789, 1234567890123456789);
INSERT INTO decimals_precision (num_decimal, num_second, num_third)VALUES (1234567890123456789.1234567890123456789, 1234567890123456789.1234567890123456789, 1234567890123456789.1234567890123456789);
SELECT * FROM decimals_precision;