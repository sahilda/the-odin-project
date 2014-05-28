def caesar_cipher text, offset
    upper_letters = ("A".ord.."Z".ord).to_a
    lower_letters = ("a".ord.."z".ord).to_a
    output = ""

    text.split("").each do |char|
        new_char = char
        if char.scan(/\w/).length > 0
            if char.upcase == char
                new_char_idx = (upper_letters.index(char.ord) + offset) % 26
                new_char = upper_letters[new_char_idx].chr
            else
                new_char_idx = (lower_letters.index(char.ord) + offset) % 26
                new_char = lower_letters[new_char_idx].chr
            end
        end
        output += new_char
    end

    output
end
