def fib(n)
	return 0 if n == 0
	return 1 if n == 1
	fib(n-1) + fib(n-2)
end

def fibs( n, result = [0,1] )
	n < 3 ? (return result[0...n]) : (2...n).each { | idx | result[idx] = result[idx-1] + result[idx-2] }
	result
end

def fibs_rec( n, result = [0,1], cur = result.size )
	result.size >= n ? (return result[0...n]) : (result[cur] = result[cur - 1] + result[cur - 2]; fibs_rec(n, result))
end