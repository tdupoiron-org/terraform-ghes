const { listPrimes } = require('./primes');

// Test case 1: n = 10
console.log(listPrimes(10)); // Expected output: [2, 3, 5, 7]

// Test case 2: n = 20
console.log(listPrimes(20)); // Expected output: [2, 3, 5, 7, 11, 13, 17, 19]

// Test case 3: n = 30
console.log(listPrimes(30)); // Expected output: [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

// Test case 4: n = 50
console.log(listPrimes(50)); // Expected output: [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]