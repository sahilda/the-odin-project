def titleize(words)
    words = words.split(' ')
    title = words[0].capitalize
    words[1..-1].each do |word|
        if word.downcase == 'and' or word.downcase == 'the' or word.downcase == 'over'
            title += ' ' + word
        else
            title += ' ' + word.capitalize
        end
    end
    title
end

def echo(words)
    words
end

def shout(words)
    words.upcase
end

def repeat(word,times=2)
    word + (' ' + word)*(times-1)
end

def start_of_word(word,times)
    word[0...times]
end

def first_word(words)
    words.split(' ')[0]
end
