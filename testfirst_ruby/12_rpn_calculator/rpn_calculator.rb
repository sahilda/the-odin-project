class RPNCalculator
	attr_accessor :stack

	def initialize
		@stack = []
		@value = nil
	end

	def push num
		@stack.push(num)
	end

	def empty
		if @stack[0] == nil
			raise "calculator is empty" 
		end
	end

	def plus
		empty
		@value = @stack.pop + @stack.pop
		@stack.push(@value)
	end

	def minus
		empty
		@value = -(@stack.pop - @stack.pop)
		@stack.push(@value)
	end

	def divide
		empty
		@value = 1.0/(@stack.pop.to_f / @stack.pop)
		@stack.push(@value)
	end

	def times
		empty
		@value = (@stack.pop * @stack.pop)
		@stack.push(@value)
	end

	def value
		if @stack.size == 1
			@value = @stack[0]
		else
			@value
		end
	end

	def tokens str
		result = []
		str.split(" ").each do |char|
			if (/[0-9]+/ =~ char) != nil
				result.push(char.to_i)
			else
				result.push(char.to_sym)
			end
		end
		result
	end

	def evaluate str
		form = tokens(str)
		@stack = []
		form.each do |char|
			case char
			when :+
				plus
			when :-
				minus
			when :*
				times
			when :/
				divide
			else
				push char
			end
		end
		value
	end

end