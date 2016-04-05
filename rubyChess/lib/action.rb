require "./piece.rb"
require "./board.rb"
require 'yaml'

class Action
	def new_game(p1=:human, p2=:human)
		clear_board
		@checkmate = false
		@player_to_act = nil
		@p1 = p1
		@p2 = p2
		@result = nil
		reset_board
		@turn = 0

		game
	end

	def game
		players = [:w, :b]
		while !@checkmate
			clear_board
			print "#{@result}\n"
			print_board
			@player_to_act = players[@turn % 2]
			if (@player_to_act == :w && @p1 == :human) || (@player_to_act == :b && @p2 == :human)
				@result = human_action(@player_to_act)
			else
				@result = computer_action(@player_to_act)
			end

			end_game if @result == 'save'
			@turn += 1
		end

		return end_game
	end

	def make_move(input)
		from_pos = input[0]
		to_pos = input[1]

		result = @board.legal_move?(from_pos, to_pos)

		if result == true
			@board.move_piece(from_pos, to_pos)
		else
			# assuming only humans can mess up here
			print "Your king will be in check. " if result == 'check'
			print "Not a legal move. Select again.\n"
			color = @board.get_piece(from_pos).get_color
			return human_action(color)
		end
	end

	def action(color, input)
		# Try player selection against game logic and execute
		make_move(input)

		# Check if opponent player is in check
		opponent_color = color == :w ? :b : :w
		if @board.in_check?(opponent_color)
			if game_end?(opponent_color)
				return "checkmate"
			else
				return "check" 
			end
		end
	end

	# TODO add computer player
	def computer_action(color)
	end

	def human_action(color)
		# Get player input and validate selection
		print "\nEnter in your move selection. For example, \"a2 a4\". Type 'save' to save.\n"
		input = get_valid_input(color)

		return 'save' if input == 'save'

		action(color, input)
	end

	def get_valid_input(color)
		input = move_translator(get_input)

		# TODO Check for save
		return 'save' if input == 'save'

		# Confirm player selected moves on the board
		if input == false
			print "Bad selection, try again.\n"
			return get_valid_input(color)
		end

		from_pos = input[0]
		to_pos = input[1]

		# Confirm player selected a piece to move
		if @board.empty_square?(from_pos)
			print "No piece selected, try again.\n"
			return get_valid_input(color)
		end

		# Confirm player selected their own piece
		if @board.get_piece(from_pos).get_color != color
			print "Wrong color selected, try again.\n"
			return get_valid_input(color)
		end

		# Confirm player isn't moving onto their own piece
		if @board.get_piece(to_pos) != nil && @board.get_piece(to_pos).get_color == color
			print "Can't move a piece on top of another one of your pieces, try again.\n"
			return get_valid_input(color)
		end

		return input
	end

	def move_translator(string)
		string = string.downcase.strip.sub(" ","")

		if string == 'save'
			save_game
			return 'save'
		end

		from_x = ['a','b','c','d','e','f','g','h'].find_index(string[0])
		from_y = ['1','2','3','4','5','6','7','8'].find_index(string[1])
		to_x = ['a','b','c','d','e','f','g','h'].find_index(string[2])
		to_y = ['1','2','3','4','5','6','7','8'].find_index(string[3])
		return false if (from_x == nil || from_y == nil || to_x == nil || to_y == nil)
		
		[[from_x, from_y], [to_x, to_y]]
	end

	def game_end?(color)
		if @board.checkmate?(color)
			@checkmate = true
			return true
		end
		false
	end

	def print_board
		@board.print_board
	end

	def clear_board
		system "clear"
	end

	def reset_board
		@board = Board.new
	end

	def get_input
		gets
	end

	def save_game
		yaml = YAML::dump(self)
		puts 'Enter save file name (no spaces please).'
		save = gets.strip.split(" ")[0]
		save_file = File.new("../saves/#{save}.yaml", 'w')
		save_file.write(yaml)
	end

	def load_game
		saves = check_save_files
	
		puts 'Enter the file name you wish to load.'
		load_file = gets.strip
		yaml = "../saves/#{load_file}"
		if saves.include?(yaml)
			load = YAML::load_file(yaml)
			load.clear_board
			load.print_board
			return load.game
		end
		
		puts "Invalid file name.\n\n"
		return load_game
	end
	
	def check_save_files
		saves = Dir.glob('../saves/*')
		if saves.empty?
			puts 'No save files. Starting new game.'
			return new_game
		end
		puts "Current saves:"
		puts saves.join(', ')
		puts "\n"
		saves
	end

	def end_game
		print "Thanks for playing."
		abort
	end

end