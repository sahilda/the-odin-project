class Knight
	def self.legal_move?(move=[0,0])
		max_board = 7
		min_board = 0
		return true if ((move[0] >= min_board && move[0] <= max_board) && (move[1] >= min_board && move[1] <= max_board))
		false
	end

	def self.possible_moves(start=[0,0])
		possible_moves = []
		possible_moves << [start[0] + 1, start[1] + 2]
		possible_moves << [start[0] + 1, start[1] - 2]
		possible_moves << [start[0] - 1, start[1] + 2]
		possible_moves << [start[0] - 1, start[1] - 2]
		possible_moves << [start[0] + 2, start[1] + 1]
		possible_moves << [start[0] + 2, start[1] - 1]
		possible_moves << [start[0] - 2, start[1] + 1]
		possible_moves << [start[0] - 2, start[1] - 1]
		possible_moves
	end

	def self.legal_moves(start=[0,0])
		possible_moves(start).select { | move | legal_move?(move) }
	end
end

class Knight_node
	attr_accessor :value, :parent, :children, :moves

	def initialize(value, parent=nil)
		@value = value
		@parent = parent
		@moves = Knight.legal_moves(value)
		@children = []
	end
end

class Knight_tree

	def initialize (start)
		@head = Knight_node.new(start, 0)
	end

	def make_tree(cur_node=@head, depth=0, max)
		if depth <= max
			cur_node.moves.each { | move | cur_node.children << Knight_node.new(move, cur_node) }	
			cur_node.children.each { | child | make_tree(child, depth+1, max) }
		end
	end

	def breadth_first_search(target)
		queue = [@head]
		visited = [@head]
		return @head if @head.value == target

		while queue.size > 0
			cur_node = queue.shift
			cur_node.children.each do | child | 
				if !visited.include?(child)
					return child if child.value == target
					queue << child
					visited << child
				end
			end
		end
	end

end

def knight_moves(start, target)
	k = Knight_tree.new(start)
	k.make_tree(max=5)
	last_node = k.breadth_first_search(target)

	moves = []
	while true
		moves << last_node.value
		break if last_node.value == start
		last_node = last_node.parent
	end

	moves.reverse!
	puts "You made it in #{moves.size - 1} moves! Here's your path:"
	moves.each { | move | p move }
end

knight_moves([3,3],[4,3])
