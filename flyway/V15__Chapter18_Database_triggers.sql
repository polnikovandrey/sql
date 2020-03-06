CREATE DATABASE trigger_demo;
USE trigger_demo;

# Trigger usage for validation example.
CREATE TABLE users(
    username VARCHAR(100),
    age INT
);
INSERT INTO users (username, age) VALUES ('bobby', 23);
# Next query is valid, there is no trigger to validate age.
INSERT INTO users (username, age) VALUES ('sally', 16);
INSERT INTO users (username, age) VALUES ('jacky', 27);
# Start of a trigger code. This trigger is used for validation. Usually validation is implemented on the sql-client side.

/*
DELIMITER is used to override semicolon (;) as a signal to execute query, but use the value provided instead. Could be defined as an arbitrary value.
BEFORE could prevent action, AFTER could post process action result.
INSERT / DELETE / UPDATE .
NEW is a placeholder, referring the row being inserted/updated/deleted, OLD is referring a row that was inserted/updated/deleted.
Note on mysql errors. They contain 3 parts: specific mysql error code, sql standard code, text message. This is sql standard code.
There could exist multiple mysql error codes and messages per one sql standard code.
45000 is a standard code for unhandled user-defined exception. Is used by developers for non-mysql, non-sql errors (db logic errors, db state errors).
DELIMITER ; reverts semicolon operator meaning.
*/
DELIMITER $$
CREATE TRIGGER must_be_adult
    BEFORE
        INSERT
    ON users FOR EACH ROW
    BEGIN
        IF NEW.age < 18
            THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Must be an adult!';
        END IF;
    END;
$$
DELIMITER ;
# Now there will be an error, because age is lt 18.
# INSERT INTO users (username, age) VALUES ('sue', 15);
SHOW TRIGGERS;
DROP TRIGGER must_be_adult;

# Start of a trigger code, used to store DELETE-ed rows data (logging).
CREATE TABLE deleted_users(
    username VARCHAR(100),
    age INT,
    deleted_at TIMESTAMP DEFAULT NOW()
);
/*
Using AFTER because only actually deleted rows should be logged. BEFORE do not guarantee deletion, which could end with an error.
SET is an alternative to VALUES operator.
*/
DELIMITER $$
CREATE TRIGGER capture_deleted_users
    AFTER DELETE ON users FOR EACH ROW
    BEGIN
        INSERT INTO deleted_users
        SET
            deleted_users.username = OLD.username,
            deleted_users.age = OLD.age;
    END;
$$
DELIMITER ;
DELETE FROM users WHERE username IN ('bobby', 'sally');
SELECT COUNT(*) AS deleted_users_count FROM deleted_users;      /* deleted_users_count = 2 */

# List triggers, existing in database being used.
SHOW TRIGGERS;
# Removes a trigger from database being used.
DROP TRIGGER capture_deleted_users;

DROP TABLE deleted_users;
DROP TABLE users;
DROP DATABASE trigger_demo;