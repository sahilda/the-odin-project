def bubble_sort ary
	iterations = 1
	while true
		swaps, idx = 0, 0
		(ary.length - iterations).times do
			if ary[idx+1] < ary[idx]
				temp = ary[idx]
				ary[idx] = ary[idx+1]
				ary[idx+1] = temp
				swaps += 1
			end
			idx += 1
		end
		iterations += 1
		return ary if swaps == 0
	end
end

def bubble_sort_by ary
	iterations = 1
	while true
		swaps, idx = 0, 0
		(ary.length - iterations).times do
			if yield(ary[idx],ary[idx+1]) < 0
				temp = ary[idx]
				ary[idx] = ary[idx+1]
				ary[idx+1] = temp
				swaps += 1
			end
			idx += 1
		end
		iterations += 1
		return ary if swaps == 0
	end
end