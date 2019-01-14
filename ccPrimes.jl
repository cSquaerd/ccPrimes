"""
# Description
Module with efficient boolean-list prime testing function.

# Functions
* `allFactors`: returns a list of all factors of an integer `n`
* `allBaseFactors`: returns a list of all factors \$\\{x | 1 < x < \\sqrt{n}\\}\$ of an integer `n`
* `isPrime`: checks the length of either `allBaseFactors` or `allFactors` to see if an integer `n` is prime
* `primesLessThan`: returns a tuple with a count of and a list of all prime numbers \$\\{p | 1 < p < n\\}\$ up to a limit of `n`
* `nextPrime`: returns the next prime number larger than `n`
* `prevPrime`: returns the previous prime number smaller than `n`
* `primesBetween`: returns a tuple with a count of and a list of all prime numbers \$\\{p | a < p < b\\}\$ larger than `a` and less than `b`
* `firstNPrimes`: returns a list of the first `n` prime numbers
"""
module ccPrimes
	export allFactors, allBaseFactors, isPrime, primesLessThan, nextPrime, prevPrime, primesBetween, firstNPrimes

	argErrorStr = "`n` must be postivie"

	"Given a positive integer `n`, returns a list of all factors of `n`"
	function allFactors(n::Integer)
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		factorBools = falses(n)
		for i = 1:n
			n % i == 0 ? factorBools[i] = true : continue
		end
		findall(factorBools)
	end

	"Given a positive integer `n`, returns a list of all factos of `n` less than or equal to the square root of `n`"
	function allBaseFactors(n::Integer)
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		local m = Int(round(sqrt(n)))
		factorBools = falses(m)
		for i = 1:m
			n % i == 0 ? factorBools[i] = true : continue
		end
		findall(factorBools)
	end

	"Given a positive integer `n`, returns a Boolean value indicating if `n` is a prime number"
	function isPrime(n::Integer, fast::Bool=true)
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		n > 1 && n % 2 != 0 ?
			fast ?
				length(allBaseFactors(n)) == 1 :
				length(allFactors(n))  == 2 :
			n == 2 ?
				true :
				false
	end

	"Given a positive integer `n`, returns the number of and a list of primes less than `n`"
	function primesLessThan(n::Integer, fast::Bool=true)
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		local primes = fast ?
			findall(x -> isPrime(x), collect(1:n - 1)) :
			findall(x -> isPrime(x, false), collect(1: n - 1))
		(length(primes), primes)
	end

	"Given a postivie integer `n`, returns the next prime larger than `n`"
	function nextPrime(n::Integer)
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		local m = n % 2 == 0 ?
			n + 1 :
			n == 1 ?
				n + 1 :
				n + 2
		while !isPrime(m) m += 2 end
		m
	end

	"Given a positive integer `n`, returns the previous prime smaller than `n`"
	function prevPrime(n::Integer)
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		local m = n % 2 == 0 ?
			n - 1 :
			n > 3 ?
				n - 2 :
				n - 1
		while !isPrime(m) && m > 1 m -= 2 end
		m > 1 ? m : throw(ErrorException("There are no smaller prime numbers than 2"))
	end

	"Given two positive integers `a` and `b` where \$a < b\$, returns the number of and a list of primes strictly between `a` and `b`"
	function primesBetween(a::Integer, b::Integer, fast::Bool=true)
		a > 0 && b > 0 ? a < b ? true :
			throw(ArgumentError("`a` must be less than `b`")) :
		throw(ArgumentError("`a` and `b` must both be positive"))

		local primes = fast ?
			map(x -> x + a, findall(x -> isPrime(x), collect(a + 1:b - 1))) :
			map(x -> x + a, findall(x -> isPrime(x, false), collect(a + 1:b - 1)))
		(length(primes), primes)
	end

	"Given a positive integer `n`, returns a list of the first `n` prime numbers"
	function firstNPrimes(n::Integer)
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		local primes = [2]
		local m = 2
		while length(primes) < n
			m = nextPrime(m)
			push!(primes, m)
		end
		primes
	end
end
