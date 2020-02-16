'use strict';
const express = require('express');
const app = express();
app.get('/', (req, res) => {
    res.send('Server response\n');
});
app.listen(3000);
console.log(new Date() + ': Running express on http://localhost:3000');