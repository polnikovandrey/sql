const express = require('express');
const app = express();
app.get('/', (req, res) => {
    res.send('Server response\n');
});
app.listen(3000);
console.log('Running on http://localhost:3000');