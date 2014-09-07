class Node
	attr_accessor :left, :right, :parent, :value

	def initialize(value, parent = nil)
		@value = value
		@parent = parent
	end
end

def build_tree(arr)
	root = nil
	arr.each do | value |
		if root == nil
			root = Node.new(value)
		else
			set = nil
			cur_node = root
			while not set
				if value > cur_node.value
					if cur_node.right == nil
						cur_node.right = Node.new(value, parent = cur_node)
						set = true
					else
						cur_node = cur_node.right
					end
				else
					if cur_node.left == nil 
						cur_node.left = Node.new(value, parent = cur_node)
						set = true
					else
						cur_node = cur_node.left
					end
				end
			end
		end
	end
	return root
end

def get_tree_seq(node, result = [])
	get_tree_seq(node.left, result) if node.left
	result << node.value
	get_tree_seq(node.right, result) if node.right
	return result
end

def get_tree_seq_arr(node, result = [], level= 0)
	node.left ? get_tree_seq_arr(node.left, result, level + 1) : (result[level+1] == nil ? result[level+1] = [" "] : result[level+1] << " ")
	result[level] == nil ? result[level] = [node.value] : result[level] << node.value
	node.right ? get_tree_seq_arr(node.right, result, level + 1) : (result[level+1] == nil ? result[level+1] = [" "] : result[level+1] << " ")
	return result[0...-1]
end

a = build_tree([4,1,0, -99, 23, 3, 5, 199, 8, 2])
p get_tree_seq(a)
get_tree_seq_arr(a).each { |line| puts "#{line.join(" ")}\n"}
