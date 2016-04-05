require "./piece.rb"
require "./board.rb"
require "./action.rb"

class Game
	def initialize 
		action = Action.new
		print "Would you like to load a game? Enter in 'l' if so."
		if gets.strip == 'l'
			action.load_game
		else
			action.new_game
		end
	end

end

game = Game.new