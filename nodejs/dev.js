'use strict';
console.log(new Date() + ': Running dev script');
const faker = require('faker');

generateAddress();

function generateAddress() {
    console.log(faker.address.streetAddress());
    console.log(faker.address.city());
    console.log(faker.address.state());
}