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
    executeWithDivider('generateAddress()', function() {
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
    password: 'legacy_auth_path'
});
function firstQuery(connection, attempt) {
    connection.query('SELECT 2 + 2 as value', function (error, results) {
        if (error) {
            if (attempt < 100) {
                // Waiting for flyway to append legacy_auth_user.
                console.log(new Date() + ' Waiting mysql connection...');
                setTimeout(firstQuery(connection, attempt + 1), 1000);
            } else {
                throw error;
            }
        } else {
            executeWithDivider('firstQuery()', function() {
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
        executeWithDivider('queryNamedResults()', function() {
            console.log(results[0].time);
            console.log(results[0].date);
            console.log(results[0].aNow);
        });
    });
}
queryNamedResults(connection);

connection.end();