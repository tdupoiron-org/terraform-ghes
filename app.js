// create a function to test if a number is prime

function isPrime(num) {
  if (num < 2) {
    return false;
  }
  for (let i = 2; i < num; i += 1) {
    if (num % i === 0) {
      return false;
    }
  }
  return true;
}

/**
 * Generates a list of prime numbers up to the specified upper limit.
 * 
 * @param {number} upperLimit - The upper limit for generating prime numbers.
 * @returns {number[]} - An array of prime numbers.
 */
function listPrimes(upperLimit) {
  const primes = [];
  for (let i = 2; i <= upperLimit; i++) {
    if (isPrime(i)) {
      primes.push(i);
    }
  }
  return primes;
}

// create a main function to test listPrimes

function main() {
  console.log(listPrimes(100));
}

main();