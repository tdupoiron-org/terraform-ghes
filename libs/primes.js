// create a function to test if a number is prime
function isPrime(n) {
  if (n < 2) return false;
  for (let i = 2; i <= Math.sqrt(n); i++) {
    if (n % i === 0) return false;
  }
  return true;
}

// create a function to list all prime numbers up to n
function listPrimes(n) {
  let primes = [];
  for (let i = 2; i <= n; i++) {
    if (isPrime(i)) primes.push(i);
  }
  return primes;
}

// export the function
module.exports = listPrimes;

// create a main function for local testing
function main() {

  // test the listPrimes function
  const startTime = performance.now();
  console.log(listPrimes(300000));
  const endTime = performance.now();
  const duration = endTime - startTime;
  console.log(`Duration: ${duration} milliseconds`);

}

// run the main function
main();