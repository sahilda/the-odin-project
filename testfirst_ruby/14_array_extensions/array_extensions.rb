class Array
	def sum
		result = 0
		self.each do |elem|
			result += elem
		end
		result
	end

	def square
		result = []
		self.each do |elem|
			result.push elem**2
		end
		result
	end

	def square!
		idx = 0
		self.each do |elem|
			self[idx] = elem**2
			idx += 1
		end
	end

end
