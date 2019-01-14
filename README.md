# ccPrimes
## A Prime Number module written in Julia

### Description
Module with efficient boolean-list prime testing function.

### Functions
* `allFactors`: returns a list of all factors of an integer `n`
* `allBaseFactors`: returns a list of all factors \$\\{x | 1 < x < \\sqrt{n}\\}\$ of an integer `n`
* `isPrime`: checks the length of either `allBaseFactors` or `allFactors` to see if an integer `n` is prime
* `primesLessThan`: returns a tuple with a count of and a list of all prime numbers \$\\{p | 1 < p < n\\}\$ up to a limit of `n`
* `nextPrime`: returns the next prime number larger than `n`
* `prevPrime`: returns the previous prime number smaller than `n`
* `primesBetween`: returns a tuple with a count of and a list of all prime numbers \$\\{p | a < p < b\\}\$ larger than `a` and less than `b`
* `firstNPrimes`: returns a list of the first `n` prime numbers
