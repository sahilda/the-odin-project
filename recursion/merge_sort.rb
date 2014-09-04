def merge_sort(ary = [])
	return ary if ary.size == 1

	## Divide
	a1 = ary[0...ary.size/2]
	a2 = ary[ary.size/2..-1]

	## Conquer
	a1 = merge_sort(a1)
	a2 = merge_sort(a2)

	## Merge
	result = []
	idx1, idx2 = 0, 0

	while result.size < (a1.size + a2.size)
		if idx1 == a1.size
			(result << a2[idx2..-1]).flatten!
		elsif idx2 == a2.size
			(result << a1[idx1..-1]).flatten!
		elsif a1[idx1] <= a2[idx2]
			result << a1[idx1]
			idx1 += 1
		else
			result << a2[idx2]
			idx2 += 1
		end
	end

	return result
end
		
a = [1, 3, 2, 10, -9, 12, 4, 3, 2, 4, 1223, 44, 9, 12, 8]
p merge_sort(a)
