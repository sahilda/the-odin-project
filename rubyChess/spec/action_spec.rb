require 'rspec'
require_relative '../lib/action'
require_relative '../lib/piece'
require_relative '../lib/board'

describe Action do
	
	before :each do 
		@action = Action.new
		@action.reset_board
	end

	describe "#move_translator" do
		it "takes an input with space and translates well" do
			expect(@action.move_translator("a2 a3")).to eq([[0,1],[0,2]])
		end

		it "takes an input with no space and translates well" do
			expect(@action.move_translator("d4 e3")).to eq([[3,3],[4,2]])
		end
	end

	describe "#get_valid_input" do
		it "returns input with a correct move" do
			def @action.get_input; "a2 a3" end
			expect(@action.get_valid_input(:w)).to eq([[0,1],[0,2]])
		end
	end

end