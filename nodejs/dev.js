'use strict';
console.log(new Date() + ': Running dev script');
const faker = require('faker');

function divider(functionName, start) {
    if (start) console.log('');
    console.log('---- ' + (start ? 'Start of ' : 'End of ') + functionName + ' ----')
}
function executeWithDivider(functionName, command) {
    divider(functionName, true);
    command();
    divider(functionName, false);
}

function generateAddress() {
    executeWithDivider('generateAddress()', function () {
        console.log(faker.address.streetAddress(false));
        console.log(faker.address.city());
        console.log(faker.address.state());
    });
}
generateAddress();

const mysql = require('mysql');
// Mysql server >8.0 authentication was not supported. Using legacy auth. See V14__Chapter16_Introducing_node.sql comment.
let connection = mysql.createConnection({
    host: 'mysql',
    user: 'legacy_auth_user',
    password: 'legacy_auth_path',
    database: 'join_us'
});
function firstQuery(connection, attempt) {
    connection.query('SELECT 2 + 2 as value', function (error, results) {
        if (error) {
            if (attempt < 100) {
                // Waiting for flyway to append legacy_auth_user.
                console.log(new Date() + ' Waiting mysql connection...');
                setTimeout(function() {
                    firstQuery(connection, attempt + 1);
                }, 1000);
            } else {
                throw error;
            }
        } else {
            executeWithDivider('firstQuery()', function () {
                console.log('results: ' + results);
                console.log('results[0]: ' + results[0]);
                console.log('results[0].value: ' + results[0].value);
            });
        }
    });
}
firstQuery(connection, 0);

function queryNamedResults(connection) {
    connection.query('SELECT  CURTIME() as time, CURDATE() as date, NOW() as aNow', function (error, results) {
        if (error) throw error;
        executeWithDivider('queryNamedResults()', function () {
            console.log(results[0].time);
            console.log(results[0].date);
            console.log(results[0].aNow);
        });
    });
}
queryNamedResults(connection);

function createTable(connection) {
    const createTableQuery = 'CREATE TABLE users (email VARCHAR(255) PRIMARY KEY, created_at TIMESTAMP DEFAULT NOW()\n);';
    connection.query(createTableQuery, function (error) {
        if (error) throw error;
        executeWithDivider('createTable()', function () {
            console.log('Table users created');
        });
    });
}
createTable(connection);

function insertUserHardcoded(connection) {
    const hardcodedInsertQuery = 'INSERT INTO users (email) VALUES ("jenna18@tut.by")';
    connection.query(hardcodedInsertQuery, function (error, results) {
        if (error) throw error;
        executeWithDivider('insertUserHardcoded()', function () {
            console.log('Affected rows: ' + results.affectedRows);
        });
    });
}
insertUserHardcoded(connection);

function insertUserDynamic(connection) {
    const user = {
        email: faker.internet.email(),
        created_at: faker.date.past()       // Note: mysql lib converts js date to a valid mysql date format
    };
    const dynamicInsertQuery = 'INSERT INTO users SET ?';
    const end_result = connection.query(dynamicInsertQuery, user, function (error, results) {
        if (error) throw error;
        executeWithDivider('insertUserDynamic()', function () {
            console.log('Affected rows: ' + results.affectedRows);
            console.log('Compiled sql: ' + end_result.sql);
        });
    });
}
insertUserDynamic(connection);

function selectAllUsers(connection) {
    const query = 'SELECT * FROM users';
    connection.query(query, function (error, results) {
        if (error) throw error;
        executeWithDivider('selectAllUsers()', function () {
            console.log(results);
        });
    });
}
selectAllUsers(connection);

function selectCountUsers(connection) {
    const query = 'SELECT COUNT(*) AS totalUsers FROM users';
    connection.query(query, function (error, results) {
        if (error) throw error;
        executeWithDivider('selectCountUsers()', function () {
            console.log(results);
        });
    });
}
selectCountUsers(connection);

function insert500Users(connection) {
    const query = 'INSERT INTO users (email, created_at) VALUES ?';
    const data = [];
    for (let i = 0; i < 500; i++) {
        data.push([faker.internet.email(), faker.date.past()]);
    }
    connection.query(query, [data], function(error, results) {
        if (error) throw error;
        executeWithDivider('insert500users()', function () {
            console.log('Count inserted users: ' + results.affectedRows);
        })
    });
}
insert500Users(connection);

function findEarliestUserCreatedAtDate(connection) {
    // Variant: const query = 'SELECT DATE_FORMAT(MIN(created_at), "%M %D %Y") AS earliest_date FROM users';
    const query = 'SELECT DATE_FORMAT(created_at, "%M %D %Y") AS earliest_date FROM users ORDER BY created_at LIMIT 1';
    connection.query(query, function(error, results) {
        if (error) throw error;
        executeWithDivider('findEarliestUserCreatedAtDate()', function () {
            console.log(results);
        });
    });
}
findEarliestUserCreatedAtDate(connection);

function findEarliestUserEmail(connection) {
    const query = 'SELECT email FROM users ORDER BY created_at LIMIT 1';
    connection.query(query, function(error, results) {
        if (error) throw error;
        executeWithDivider('findEarliestUserEmail()', function () {
            console.log(results);
        });
    });
}
findEarliestUserEmail(connection);

function countUsersPerMonth(connection) {
    const query = 'SELECT MONTHNAME(created_at) AS month, COUNT(*) AS count FROM users GROUP BY month ORDER BY count DESC';
    connection.query(query, function(error, results) {
        if (error) throw error;
        executeWithDivider('countUsersPerMonth()', function () {
            console.log(results);
        });
    });
}
countUsersPerMonth(connection);

function countYahooUsers(connection) {
    const query = 'SELECT COUNT(*) AS yahoo_users FROM users WHERE email LIKE "%@yahoo.com"';
    connection.query(query, function(error, results) {
        if (error) throw error;
        executeWithDivider('countYahooUsers()', function () {
            console.log(results);
        });
    });
}
countYahooUsers(connection);

function countUsersPerHost(connection) {
    /*
        Variant: const query = 'SELECT' +
            ' CASE' +
        ' WHEN email LIKE "%gmail.com" THEN "gmail"' +
        ' WHEN email LIKE "%yahoo.com" THEN "yahoo"' +
        ' WHEN email LIKE "%hotmail.com" THEN "hotmail"' +
        ' ELSE "other" END' +
        ' AS host, COUNT(*) AS users FROM users GROUP BY host ORDER BY users DESC';
     */
    const query = 'SELECT' +
        ' CASE SUBSTRING_INDEX(SUBSTRING_INDEX(email, "@", -1), ".", 1)' +
        ' WHEN "gmail" THEN "gmail"' +
        ' WHEN "yahoo" THEN "yahoo"' +
        ' WHEN "hotmail" THEN "hotmail"' +
        ' ELSE "other" END' +
        ' AS host, COUNT(*) AS users FROM users GROUP BY host ORDER BY users DESC';
    connection.query(query, function(error, results) {
        if (error) throw error;
        executeWithDivider('countUsersPerHost()', function () {
            console.log(results);
        });
    });
}
countUsersPerHost(connection);

connection.end();