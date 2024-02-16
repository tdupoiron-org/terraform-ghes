// create a function to test if a number is prime
/**
 * Checks if a number is prime.
 * @param {number} n - The number to check.
 * @returns {boolean} - True if the number is prime, false otherwise.
 */
function isPrime(n) {
  if (n < 2) return false;
  for (var i = 2; i <= Math.sqrt(n); i++) {
    if (n % i === 0) return false;
  }
  return true;
}

// create a function to list all primes up to a number
/**
 * Generates a list of prime numbers up to a given number.
 *
 * @param {number} n - The upper limit for generating prime numbers.
 * @returns {number[]} - An array of prime numbers.
 */
function listPrimes(n) {
  var primes = [];
  for (var i = 2; i <= n; i++) {
    if (isPrime(i)) primes.push(i);
  }
  return primes;
}

// export the function
module.exports = isPrime;

// create a main to test the listPrimes function
function main() {
  console.time("listPrimes");
  listPrimes(300000);
  console.timeEnd("listPrimes");
}

// run the main
main();