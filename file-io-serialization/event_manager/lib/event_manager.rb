require 'csv'
require 'sunlight/congress'
puts "EventManager Initialized!"

def clean_zipcode(zipcode)
	zipcode.to_s[0..4].rjust(5,"0")
end

def get_legislator_names(legislators)
	names = legislators.collect do | legislator |
	  "#{legislator.first_name} #{legislator.last_name}"
	end
end

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

contents = CSV.open("event_attendees.csv",headers: true, header_converters: :symbol)
contents.each do | line |
	first_name = line[:first_name]
	zipcode = clean_zipcode(line[:zipcode])
	legislators = get_legislator_names(Sunlight::Congress::Legislator.by_zipcode(zipcode))
	puts "#{first_name} #{zipcode} #{legislators.join(", ")}"
end
