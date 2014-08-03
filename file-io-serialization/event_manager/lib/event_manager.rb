
require 'erb'
require 'csv'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
	zipcode.to_s[0..4].rjust(5,"0")
end

def valid_number?(number)
	number = number.gsub(/[()\s-.]/,'')
	
	if number.nil? || number.size > 11 || number.size < 9
		return false
	else
		return true if number.size == 10
		return true if number[0] == 1
	end
	false
end

def get_legislator_names(zipcode)
	Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letter(id, form_letter)
	Dir.mkdir("output") unless Dir.exists?("output")
	filename = "output/thanks_#{id}.html"

	File.open(filename, 'w') do | file |
		file.puts form_letter
	end
end


puts 'EventManager Initialized.'

contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new(template_letter)

contents.each do | line |
	id = line[0]
	first_name = line[:first_name]
	zipcode = clean_zipcode(line[:zipcode])
	phone = line[:homephone] if valid_number?(line[:homephone])
	legislators = get_legislator_names(zipcode)

	form_letter = erb_template.result(binding)
	save_thank_you_letter(id, form_letter)
end

