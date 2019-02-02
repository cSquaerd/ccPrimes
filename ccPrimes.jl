"""
# Description
Module with efficient boolean-list prime testing function.

# Functions
* `allFactors`: returns a list of all factors of an integer `n`
* `allBaseFactors`: returns a list of all factors \$\\{x | 1 \\leq x \\leq \\sqrt{n}\\}\$ of an integer `n`
* `isPerfect`: checks if the sum of an integer `n`'s proper divisors are equal to the integer
* `isPrime`: checks the length of either `allBaseFactors` or `allFactors` to see if an integer `n` is prime
* `primesLessThan`: returns a tuple with a count of and a list of all prime numbers \$\\{p | 1 < p < n\\}\$ up to a limit of `n`
* `nextPrime`: returns the next prime number larger than `n`
* `prevPrime`: returns the previous prime number smaller than `n`
* `primesBetween`: returns a tuple with a count of and a list of all prime numbers \$\\{p | a < p < b\\}\$ larger than `a` and less than `b`
* `firstNPrimes`: returns a list of the first `n` prime numbers
"""
module ccPrimes
	export allFactors, allBaseFactors, coPrimes, cc_gcd, cc_lcm, aliquotSum, isPerfect, isPrime, primesLessThan, nextPrime, prevPrime, primesBetween, firstNPrimes

	argErrorStr = "`n` must be postivie"

	"Given a positive integer `n`, returns a list of all factors of `n`"
	function allFactors(n::Integer)
		#Argument Error check
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		#Make a list of n booleans initialized to false
		factorBools = falses(n)
		#For each number 1 <= i <= n, check if i evenly divides n;
		#If so, then i is a factor of n, so set its boolean to true
		for i = 1:n
			n % i == 0 ? factorBools[i] = true : continue
		end
		#Find the indices of all true values, the factors,
		#and return a list of these indices
		findall(factorBools)
	end

	"Given a positive integer `n`, returns a list of all factors of `n` less than or equal to the square root of `n`"
	function allBaseFactors(n::Integer)
		#Argument Error check
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		#Find the nearest integer to the square root of n, call this integer m
		local m = Int(round(sqrt(n)))
		#Make a list of m booleans initialized to false
		factorBools = falses(m)
		#For each number 1 <= i <= m, check if i evenly divides n;
		#If so, then i is a factor n, and specifically, a "base" factor,
		#so set its boolean to true;
		#For example, for 24, its base factors are 1, 2, 3, and 4;
		#The respective counterparts of the base factors, 6, 8, 12, and 24,
		#make up the rest of the factors of 24
		for i = 1:m
			n % i == 0 ? factorBools[i] = true : continue
		end
		#Find the indices of all true values, the "base" factors,
		#and return a list of these indices
		findall(factorBools)
	end

	"Given two integers `m` and `n`, returns a Boolean value indicating if the integers have no common factors"
	function coPrimes(m, n)
		n > 0 && m > 0 ? true : throw(ArgumentError("`m` and " + argErrorStr))
		length(intersect(allFactors(m), allFactors(n))) == 1
	end

	"Given two integers `m` and `n`, returns the greatest common divisor of `m` and `n`"
	function cc_gcd(m::Integer, n::Integer)
		n > 0 && m > 0 ? true : throw(ArgumentError("`m` and " + argErrorStr))
		maximum(intersect(allFactors(m), allFactors(n)))
	end

	"Given two integers `m` and `n`, returns the least common multiple of `m` and `n`"
	function cc_lcm(m::Integer, n::Integer)
		n > 0 && m > 0 ? true : throw(ArgumentError("`m` and " + argErrorStr))
		div(m * n, gcd(m, n))
	end

	"Given an integer `n`, returns the sum of the proper divisors of `n`"
	function aliquotSum(n::Integer)
		n > 0 ? true : throw(ArgumentError(argErrorStr))
		sum(allFactors(n)[1:end - 1])
	end

	"Given an integer `n`, returns a Boolean value indicating if the sum of `n`'s proper divisors is equal to `n`"
	function isPerfect(n::Integer)
		aliquotSum(n) == n
	end

	"Given a positive integer `n`, returns a Boolean value indicating if `n` is a prime number"
	function isPrime(n::Integer, fast::Bool=true)
		#Argument Error check
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		#Is n an odd number greater than one?
		n > 1 && n % 2 != 0 ?
			#Check only the "base" factors or all factors?
			fast ?
				#Prime numbers should only have one "base" factor, 1
				length(allBaseFactors(n)) == 1 :
				#Prime numbers' only factors are 1 and itself
				length(allFactors(n))  == 2 :
			#The only even prime number is 2
			n == 2 ?
				true :
				#All even values of n > 2 will eventually reach here
				false
	end

	"Given a positive integer `n`, returns the number of and a list of primes less than `n`"
	function primesLessThan(n::Integer, fast::Bool=true)
		#Argument Error check
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		#Refer to comments on the fast boolean in isPrime
		local primes = fast ?
			#Find all numbers from 1 to n - 1 that are prime
			findall(x -> isPrime(x), collect(1:n - 1)) :
			#Same as above but check for all factors of each number
			findall(x -> isPrime(x, false), collect(1: n - 1))
		(length(primes), primes)
	end

	"Given a postivie integer `n`, returns the next prime larger than `n`"
	function nextPrime(n::Integer)
		#Argument Error check
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		#m will be the starting value; If n is even, start at the next odd number, n + 1
		local m = n % 2 == 0 ?
			n + 1 :
			#If n is odd but also equal to 1, start at 2, the first prime
			n == 1 ?
				n + 1 :
				#For all odd values of n greater than 1,
				#start at the next odd value, n + 2
				n + 2
		#This while loop will not run if m == 2,
		#but will check greater odd numbers if m is odd,
		#until a prime is found
		while !isPrime(m) m += 2 end
		m
	end

	"Given a positive integer `n`, returns the previous prime smaller than `n`"
	function prevPrime(n::Integer)
		#Argument Error check
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		#If n is even, start at the previous odd number, n - 1
		local m = n % 2 == 0 ?
			n - 1 :
			#If n is odd and larger than 3, start at the previous odd number, n - 2
			n > 3 ?
				n - 2 :
				#If n is 3, the previous prime is 2 (which is n - 1)
				n - 1
		#If m <= 2, this loop will not run,
		#but will run otherwise and check lesser odd numbers
		#until a prime is found
		while !isPrime(m) && m > 1 m -= 2 end
		#If m == 1 by the end, it is technically not prime;
		#This happens if n == 2, hence the error
		m > 1 ? m : throw(ErrorException("There are no smaller prime numbers than 2"))
	end

	"Given two positive integers `a` and `b` where \$a < b\$, returns the number of and a list of primes strictly between `a` and `b`"
	function primesBetween(a::Integer, b::Integer, fast::Bool=true)
		#Argument Error check
		a > 0 && b > 0 ? a < b ? true :
			throw(ArgumentError("`a` must be less than `b`")) :
		throw(ArgumentError("`a` and `b` must both be positive"))

		#Refer to isPrime for details on the fast Boolean
		local primes = fast ?
			#First, find all primes a < p < b;
			#The output of findall() will be indices starting from a + 1;
			#If a + 1 is prime, its index will be 1 = (a + 1) - a,
			#so the indices must all have a added to them to get the number
			map(x -> x + a, findall(x -> isPrime(x), collect(a + 1:b - 1))) :
			#Same as above but every prime check will look for all factors
			#instead of just the "base" factors
			map(x -> x + a, findall(x -> isPrime(x, false), collect(a + 1:b - 1)))
		(length(primes), primes)
	end

	"Given a positive integer `n`, returns a list of the first `n` prime numbers"
	function firstNPrimes(n::Integer)
		#Argument Error check
		n > 0 ? true : throw(ArgumentError(argErrorStr))

		#2 is the first prime, so start with a list containing it
		local primes = [2]
		local m = 2
		#Look for more primes until n have been found,
		#and do so using the nextPrime() function written above;
		#Push new primes to the list using push!()
		while length(primes) < n
			m = nextPrime(m)
			push!(primes, m)
		end
		primes
	end
end
