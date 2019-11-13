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

