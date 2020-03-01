'use strict';

const bodyParser = require('body-parser');
const ejs = require('ejs');
const express = require('express');
const mysql = require('mysql');

const connection = mysql.createConnection({
    host: 'mysql',
    user: 'legacy_auth_user',
    password: 'legacy_auth_path',
    database: 'join_us'
});

const app = express();
app.use(bodyParser.urlencoded({extended: true}));   // Using body-parser request body parser to get post request parameters.
app.set('view engine', 'ejs');      // Using ejs template engine.
app.get('/', (req, res) => {
    const query = 'SELECT COUNT(*) AS count FROM users';
    connection.query(query, function (error, results) {
        if (error) throw error;
        const count = results[0].count;
        res.render('home', {count: count});     // This will look for views/home.ejs template to render.
    });
});
app.post('/register', (req, res) => {
    const query = 'INSERT INTO users SET ?';
    connection.query(query, {email: req.body.email}, (error, results) => {
        if (error) throw  error;
        res.redirect('/');
    });
});
app.listen(3000, function () {
    console.log(new Date() + ': Running express on http://localhost:3000');
});