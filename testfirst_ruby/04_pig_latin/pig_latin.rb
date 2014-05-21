def translate(words)
	words = words.split(' ')
	pig_word = wordify(words[0])
	words[1..-1].each do |word|
		pig_word += ' ' + wordify(word)
	end
	pig_word
end

def wordify(word)
	idx_qu = word.downcase.index(/qu/)
	idx_vowles = word.downcase.index(/[aeiou]/)
	punct = ''
	if word.index(/[[:punct:]]/)
		punct = word[word.index(/[[:punct:]]/)]
		word = word.delete punct
	end

	if idx_qu
		new_word = word[(idx_qu+2)..-1] + word[0...(idx_qu+2)] + 'ay'
	else
		new_word = word[idx_vowles..-1] + word[0...idx_vowles] + 'ay'
	end
	
	if is_capitalize?(word)
		new_word = new_word.capitalize
	end

	new_word + punct
end

def is_capitalize?(word)
	word == word.capitalize
end