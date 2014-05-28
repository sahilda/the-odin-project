def substrings text, dict
    output = Hash.new(0)
    text.split(" ").each do |word|
        word = word.gsub(/\W/,"").downcase
        idx1 = 0
        while idx1 < word.length
            idx2 = 0
            while idx2 < word.length
                substring = word[idx1..idx2]
                if dict.include?(substring)
                    output[substring] += 1
                end
                idx2 += 1
            end
            idx1 += 1
        end
    end
    output
end
