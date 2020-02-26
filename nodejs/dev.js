'use strict';
console.log(new Date() + ': Running dev script');
const faker = require('faker');
function divider(functionName, start) {
    if (start) console.log('');
    console.log('---- ' + (start ? 'Start of ' : 'End of ') + functionName + ' ----')
}
function generateAddress() {
    divider('generateAddress()', true);
    console.log(faker.address.streetAddress(false));
    console.log(faker.address.city());
    console.log(faker.address.state());
    divider('generateAddress()', false);
}
generateAddress();

const mysql = require('mysql');
// Mysql server >8.0 authentication was not supported. Using legacy auth. See V14__Chapter16_Introducing_node.sql comment.
let connection = mysql.createConnection({
    host: 'mysql',
    user: 'legacy_auth_user',
    password: 'legacy_auth_path'
});
function firstQuery(connection) {
    connection.query('SELECT 2 + 2 AS solution', function (error, results) {
        if (error) throw error;
        divider('firstQuery()', true);
        console.log('The solution of 2 + 2 is ' + results[0].solution);
        divider('firstQuery()', false);
    });
}
firstQuery(connection);