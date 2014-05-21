class Dictionary
	def initialize
		@entries = {}
	end

	def entries
		@entries
	end

	def add arry
		if arry.class == Hash
			arry.each do |key, value|
				@entries[key] = value
			end
		else
			@entries[arry] = nil
		end

	end

	def keywords
		@entries.keys.sort
	end

	def include? key
		@entries.keys.include? (key)
	end

	def find word
		result = {}
		@entries.each do |key, value|
			if (/^#{word}/ =~ key) != nil
				result[key] = @entries[key]
			end
		end
		result
	end

	def printable
		result = []
		@entries.each do |key, value|
			result = ['[' + key + ']' + ' "' + value + '"'] + result
		end
		result.join("\n")
	end


end
