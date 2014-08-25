require 'jumpstart_auth'
require 'bitly'
require 'klout'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializng microblogger.."
		@client = JumpstartAuth.twitter
		Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
	end

	def tweet(message)
		if message.size > 140
			puts 'The tweet is too long! Cannot process.'
			return
		end
		@client.update(message)
	end

	def dm(target, message)
		puts "Trying to send #{target} this direct message:"
		puts message

		followers = get_followers
		if followers.include?(target)
			message = "d @#{target} #{message}"
			tweet(message)
		else
			puts "Sorry, you're unable to direct message #{target}. Get them to follow your first!"
		end

	end

	def get_followers
		screen_names = @client.followers.collect { |follower| follower.screen_name }
	end

	def spam_my_followers(message)
		followers = get_followers
		followers.each { | follower | dm(follower, message) }
	end

	def everyones_last_tweet
		friends = @client.friends
		friends.sort_by { | friend | friend.screen_name.downcase }
		friends.each do | friend |
			puts "#{friend.screen_name} said this at #{friend.status.created_at.strftime("%A, %b %d")}..."
			puts "#{friend.status.text}"
		end
	end

	def shorten(original_url)
		Bitly.use_api_version_3
		bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		puts "Shortening this url #{original_url}..."
		puts bitly.shorten(original_url).short_url
		return bitly.shorten(original_url).short_url
	end

	def klout_score
		followers = get_followers
		followers.each do | follower |
			identity = Klout::Identity.find_by_screen_name(follower)
			user = Klout::User.new(identity.id)
			puts "Your follower #{follower} has a klout score of #{user.score.score}."
		end
	end

	def run
		puts "Welcome to the JSL Twitter Client!"
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp.split(" ")
			command = input[0]
			case command
				when 'q' then puts "Goodbye!"
				when 't' then tweet(input[1..-1].join(" "))
				when 'dm' then dm(input[1], input[2..-1].join(" "))
				when 'spam' then spam_my_followers(input[1..-1].join(" "))
				when 'elt' then everyones_last_tweet
				when 's' then shorten(input[1])
				when 'turl' then tweet("#{input[1..-2].join(" ")} #{shorten(input[-1])}")
				when 'klout' then klout_score
				else
					puts "Sorry, I don't know how to #{command}."
			end
		end
	end


end

blogger = MicroBlogger.new
blogger.run