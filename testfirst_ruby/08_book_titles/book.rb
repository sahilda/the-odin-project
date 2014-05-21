class Book
	attr_accessor :title

	def title= (new_title)
		new_title = new_title.split(" ")
		temp_title = new_title[0].capitalize
		
		stop_words = ['a','an','the','of','and','in']

		new_title[1..-1].each do |word|
			if stop_words.include?(word)
				temp_title += ' ' + word
			else				
				temp_title += ' ' + word.capitalize
			end
		end

		@title = temp_title
	end



end
