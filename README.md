# ccPrimes
## A Prime Number module written in Julia

### Description
Module with efficient boolean-list prime testing function.

### Functions
* `allFactors`: returns a list of all factors of an integer `n`
* `allBaseFactors`: returns a list of all factors of an integer `n`
* `isPerfect`: checks the sum of `allFactors` after popping the last entry (which is `n`) to see if an integer `n` is perfect
* `isPrime`: checks the length of either `allBaseFactors` or `allFactors` to see if an integer `n` is prime
* `primesLessThan`: returns a tuple with a count of and a list of all prime numbers up to a limit of `n`
* `nextPrime`: returns the next prime number larger than `n`
* `prevPrime`: returns the previous prime number smaller than `n`
* `primesBetween`: returns a tuple with a count of and a list of all prime numbers larger than `a` and less than `b`
* `firstNPrimes`: returns a list of the first `n` prime numbers
