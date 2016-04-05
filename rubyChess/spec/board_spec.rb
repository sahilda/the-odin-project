require 'rspec'
require_relative '../lib/action'
require_relative '../lib/piece'
require_relative '../lib/board'

describe Board do
	
	before :each do 
		@board = Board.new
	end

	describe "#move_piece" do
		it "moves the queen to the position" do
			queen = @board.get_piece([3,7])
			@board.move_piece([3,7], [4,5])
			expect(@board.get_piece([3,7])).to eq(nil)
			expect(@board.get_piece([4,5])).to eq(queen)
		end
	end

	describe "#get_king" do
		it "returns the kings starting position" do
			expect(@board.get_king(:w)).to eq([4,0])
		end

		it "returns moved king position" do
			@board.move_piece([4,0], [4,2])
			expect(@board.get_king(:w)).to eq([4,2])
		end
	end

	describe "#get_positions" do
		it "returns the starting positions correctly" do
			expected = []
			(0..7).each { |i| expected << [i,0] }
			(0..7).each { |i| expected << [i,1] }
			expect(@board.get_positions(:w)).to eq(expected)
		end
	end

	describe "#empty_path?" do
		it "returns false for a queen move at the start" do
			expect(@board.empty_path?([3,0],[3,5])).to eq(false)
		end
	end

	describe "#in_check?" do
		it "returns false at start of game" do
			expect(@board.in_check?(:w)).to eq(false)
		end

		it "returns true when king is in check" do
			@board.move_piece([4,0], [4,2])
			@board.move_piece([3,7], [4,5])
			expect(@board.in_check?(:w)).to eq(true)
		end
	end

	describe "legal_move?" do 
		it "returns true when a king moves with a clear path" do
			@board.move_piece([4,1], [4,3])
			expect(@board.legal_move?([4,0], [4,1])).to eq(true)
		end

		it "returns 'check' when a king moves into check" do
			@board.move_piece([4,1], [4,3])
			@board.move_piece([3,7], [2,3])
			expect(@board.legal_move?([4,0], [4,1])).to eq('check')
		end
	end

	describe "move_into_check?" do
		it "returns true when moving a pawn and opening up for check" do
			@board.move_piece([3,0], [7,4])
			expect(@board.move_into_check?([5,6], [5,4])).to eq(true)
		end
	end

end