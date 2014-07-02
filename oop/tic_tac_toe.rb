class TicTacToe
  def initialize(player1, player2)
    @player1 = Player.new(player1,:x)
    @player2 = Player.new(player2,:o)

    @board = [[' ',' ',' '],
              [' ',' ',' '],
              [' ',' ',' ']]
  end

  def reset_board
    @board = [[' ',' ',' '],
              [' ',' ',' '],
              [' ',' ',' ']]
  end

  def print_board
    puts '  ' + @board[0].join(' | ')
    puts " ---+---+---"
    puts '  ' + @board[1].join(' | ')
    puts " ---+---+---"
    puts '  ' + @board[2].join(' | ')
  end

  def place_move(piece, x, y)
    if @board[x][y] == ' '
      @board[x][y] = piece
    else
      "Invalid"
    end
  end

  def valid_input
    puts "Where would you like to go? Enter row and column number 1-3 as such: 'x,y' or even 'xy'."
    input = gets.chomp.scan(/\d/)
    while (input.select {|n| n.to_i >0 && n.to_i<4}.length) != 2
      puts "Invalid Entry. Please enter the row and column number again."
      input = gets.chomp.scan(/\d/)
    end
    input[0] = input[0].to_i - 1
    input[1] = input[1].to_i - 1
    input
  end

  def player_turn(player)
    loop do
      status
      puts "#{player.name}, your turn."
      input = valid_input
      break if place_move(player.type,input[0],input[1]) != "Invalid"
      puts "Invalid move, please place a piece again."
    end
  end

  def play
    turn = 1
    player = nil
    9.times do
      if turn % 2 == 1
        player_turn(@player1)
        player = @player1
      else
        player_turn(@player2)
        player = @player2
      end
      if game_end? == true
        status
        puts "#{player.name} wins!"
        return play_again?
      end
      turn += 1
    end
    status
    puts "Cat's game."
    return play_again?
  end

  def play_again?
    puts "Play again? (y/n)"
    input = gets.chomp.downcase
    if input == 'y'
      reset_board
      return play
    else
      puts "Thanks for playing!"
      return false
    end
  end

  def status
    print_board
  end

  def game_end?
    if @board[0][0] == @board[1][1] && @board[0][0] == @board[2][2] && @board[0][0] != ' '
      return true
    elsif @board[0][2] == @board[1][1] && @board[0][2] == @board[2][0] && @board[0][2] != ' '
      return true
    else
      (0..2).each do |n|
        if @board[n][0] == @board[n][1] && @board[n][0] ==  @board[n][2] && @board[n][0] != ' '
          return true
        elsif @board[0][n] == @board[1][n] && @board[0][n] == @board[2][n] && @board[0][n] != ' '
          return true
        end
      end
    end
    return false
  end

  class Player
    attr_accessor :name, :type
    def initialize(name, type)
      @name = name
      @type = type
    end
  end

end

game = TicTacToe.new('Sahil','Navid')
game.play
