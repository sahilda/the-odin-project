class Piece
	def initialize(color)
		@unicode = nil
		@color = color
		@moved = false
	end

	def set_moved(moved)
		@moved = moved
	end

	def position_on_board?(position)
		return false if position[0] >= 0 && position[0] <= 7 && position[1] >= 0 && position[1] <= 7
		true
	end

	def get_moved
		@moved
	end

	def get_color
		@color
	end

	def get_unicode
		@unicode
	end
end

# TODO add en passant
class Pawn < Piece 
	def initialize(color)
		super(color)
		@unicode = @color == :w ? "\u2659" : "\u265F"
	end

	def possible_moves(position, enemy_capture=false)
		moves = []

		if @color == :w
			moves << [position[0], position[1] + 1] if position[1] <= 6
			moves << [position[0], position[1] + 2] if !@moved
		else
			moves << [position[0], position[1] - 1] if position[1] >= 1
			moves << [position[0], position[1] - 2] if !@moved
		end

		if enemy_capture
			moves = []
			if @color == :w
				moves << [position[0] + 1, position[1] + 1]
				moves << [position[0] - 1, position[1] + 1]
			else
				moves << [position[0] + 1, position[1] - 1]
				moves << [position[0] - 1, position[1] - 1]
			end
		end

		moves.select { | move | position_on_board?(move) }
		return moves
	end
end

class Rook < Piece
	def initialize(color)
		super(color)
		@unicode = @color == :w ? "\u2656" : "\u265C"
	end

	def possible_moves(position, enemy_capture=false)
		moves = []
		for i in (1..7)
			moves << [position[0] + i, position[1]]
			moves << [position[0] - i, position[1]]
			moves << [position[0], position[1] + i]
			moves << [position[0], position[1] - i]
		end

		moves.select { | move | position_on_board?(move) }
		return moves
	end
end

class Knight < Piece 
	def initialize(color)
		super(color)
		@unicode = @color == :w ? "\u2658" : "\u265E"
	end

	def possible_moves(position, enemy_capture=false)
		moves = []
		moves << [position[0] + 1, position[1] + 2]
		moves << [position[0] + 1, position[1] - 2]
		moves << [position[0] - 1, position[1] + 2]
		moves << [position[0] - 1, position[1] - 2]
		moves << [position[0] + 2, position[1] + 1]
		moves << [position[0] + 2, position[1] - 1]
		moves << [position[0] - 2, position[1] + 1]
		moves << [position[0] - 2, position[1] - 1]
		moves.select { | move | position_on_board?(move) }
		return moves
	end
end

class Bishop < Piece
	def initialize(color)
		super(color)
		@unicode = @color == :w ? "\u2657" : "\u265D"
	end

	def possible_moves(position, enemy_capture=false)
		moves = []
		for i in (1..7)
			moves << [position[0] + i, position[1] + i]
			moves << [position[0] + i, position[1] - i]
			moves << [position[0] - i, position[1] + i]
			moves << [position[0] - i, position[1] - i]
		end

		moves.select { | move | position_on_board?(move) }
		return moves
	end
end

class Queen < Piece 
	def initialize(color)
		super(color)
		@unicode = @color == :w ? "\u2655" : "\u265B"
	end

	def possible_moves(position, enemy_capture=false)
		moves = []
		for x in (0..7)
			for y in (0..7)
				moves << [x,y]
			end
		end

		moves.select { | move | position_on_board?(move) }
		return moves
	end
end

# TODO add castling
class King < Piece
	def initialize(color)
		super(color)
		@unicode = @color == :w ? "\u2654" : "\u265A"
	end

	def possible_moves(position, enemy_capture=false)
		moves = []
		moves << [position[0] + 1, position[1] + 0]
		moves << [position[0] + 1, position[1] + 1]
		moves << [position[0] + 1, position[1] - 1]
		moves << [position[0] - 1, position[1] + 0]
		moves << [position[0] - 1, position[1] + 1]
		moves << [position[0] - 1, position[1] - 1]
		moves << [position[0] + 0, position[1] + 1]
		moves << [position[0] + 0, position[1] - 1]

		moves.select { | move | position_on_board?(move) }
		return moves
	end
end