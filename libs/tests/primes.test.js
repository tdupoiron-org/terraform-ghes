const listPrimes = require('../primes');

test('listPrimes returns correct primes up to 10', () => {
  expect(listPrimes(10)).toEqual([2, 3, 5, 7]);
});

test('listPrimes returns empty array for negative input', () => {
  expect(listPrimes(-5)).toEqual([]);
});

test('listPrimes returns empty array for input 0 or 1', () => {
  expect(listPrimes(0)).toEqual([]);
  expect(listPrimes(1)).toEqual([]);
});