require "./piece.rb" 

 class Board
	def initialize
		@board = Hash.new
		new_setup
	end

	def new_setup
		@board[[0,0]] = Rook.new(:w)
		@board[[1,0]] = Knight.new(:w)
		@board[[2,0]] = Bishop.new(:w)
		@board[[3,0]] = Queen.new(:w,)
		@board[[4,0]] = King.new(:w)
		@board[[5,0]] = Bishop.new(:w)
		@board[[6,0]] = Knight.new(:w)
		@board[[7,0]] = Rook.new(:w)
		(0..7).each { |i| @board[[i,1]] = Pawn.new(:w) }

		@board[[0,7]] = Rook.new(:b)
		@board[[1,7]] = Knight.new(:b)
		@board[[2,7]] = Bishop.new(:b)
		@board[[3,7]] = Queen.new(:b)
		@board[[4,7]] = King.new(:b)
		@board[[5,7]] = Bishop.new(:b)
		@board[[6,7]] = Knight.new(:b)
		@board[[7,7]] = Rook.new(:b)
		(0..7).each { |i| @board[[i,6]] = Pawn.new(:b) }
	end

	def move_piece(from_pos, to_pos)
		@board[to_pos] = @board[from_pos]
		@board.delete(from_pos)
		@board[to_pos].set_moved(true)
	end

	def empty_square?(pos)
		@board[pos] == nil ? true : false
	end

	def get_piece(pos)
		@board[pos]
	end

	def legal_move?(from_pos, to_pos)
		return false if !move_possible?(from_pos, to_pos)
		return 'check' if move_into_check?(from_pos, to_pos)

		true
	end

	def move_possible?(from_pos, to_pos)
		enemy_capture = empty_square?(to_pos) ? false : true
		return false if !get_piece(from_pos).possible_moves(from_pos, enemy_capture).include?(to_pos)
		return false if !empty_path?(from_pos, to_pos)
		true
	end

	def move_into_check?(from_pos, to_pos)
		from_piece = get_piece(from_pos)
		to_piece = get_piece(to_pos)
		
		move_piece(from_pos, to_pos)
		check = in_check?(from_piece.get_color)

		# Undo the move
		move_piece(to_pos, from_pos)
		@board[to_pos] = to_piece
		from_piece.set_moved(false)

		return check
	end

	def in_check?(color)
		king = get_king(color)
		opponent_positions = color == :w ? get_positions(:b) : get_positions(:w)

		for position in opponent_positions
			return true if move_possible?(position, king) == true
		end

		false
	end

	# TODO fix
	def checkmate?(color)
		return false if in_check?(color) == false
		king = get_piece(get_king(color))

		# check if the king can move anywhere
		for move in king.possible_moves(get_king(color), true)
			return false if legal_move?(get_king(color), move) 
		end

		# TODO check if another piece can protect the king
		true
	end

	def get_king(color)
		for position in @board.keys
			return position if get_piece(position).instance_of?(King) && get_piece(position).get_color == color
		end
	end

	def get_positions(color)
		positions = []
		for position in @board.keys
			positions << position if get_piece(position).get_color == color
		end
		positions
	end

	def get_distance(from_pos, to_pos)
		Math.sqrt( (from_pos[0] - to_pos[0])**2 + (from_pos[1] - to_pos[1])**2 )
	end 

	def empty_path?(from_pos, to_pos)

		# Return true if piece is only moving 1 square away
		return true if (get_distance(from_pos, to_pos) == 1 || get_distance(from_pos, to_pos) == Math.sqrt(2))

		# Skip check if moving piece is a Knight
		return true if get_piece(from_pos).instance_of?(Knight)

		x_low = [from_pos[0], to_pos[0]].min
		x_high = [from_pos[0], to_pos[0]].max
		y_low = [from_pos[1], to_pos[1]].min
		y_high = [from_pos[1], to_pos[1]].max

		# check vertical path
		if (from_pos[0] == to_pos[0])
			x = from_pos[0]
	
			for y in ((y_low+1)...y_high)
				return false if !empty_square?([x,y])
			end
		
		# check horizontal path
		elsif (from_pos[1] == to_pos[1])
			y = from_pos[1]
	
			for x in ((x_low+1)...x_high)
				return false if !empty_square?([x,y])
			end

		# check diagonal path
		else
			# confirm that indeed it is a diagonal move, ie it's moving horizontally as much as it is vertically
			return false if (x_high - x_low != y_high - y_low)
			return diagonal_empty_path?(from_pos, to_pos)
		end

		true
	end

	def diagonal_empty_path?(from_pos, to_pos)
		low_x_pos = from_pos[0] < to_pos[0] ? from_pos : to_pos
		high_x_pos = from_pos[0] < to_pos[0] ? to_pos : from_pos

		for i in (1...(low_x_pos[0] - high_x_pos[0]).abs)
			if (low_x_pos[0] - high_x_pos[0]) == (low_x_pos[1] - high_x_pos[1]) 
				return false if !empty_square?([low_x_pos[0]+i, low_x_pos[1]+i])
			else
				return false if !empty_square?([low_x_pos[0]+i, low_x_pos[1]-i])
			end
		end

		true
	end

	def print_board
		counter = 8

		for y in 7.downto(0)
			print "#{counter}  "
			for x in (0..7)
				position = [x,y]
				print @board[position] == nil ? "*" : @board[position].get_unicode
				print "  "
			end
			counter -= 1
			print "\n"
		end
		print "   A  B  C  D  E  F  G  H\n"
	end

end