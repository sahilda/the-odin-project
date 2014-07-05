class TicTacToe
  Player = Struct.new(:name, :type)

  def initialize
    puts "Enter player 1 name:"
    name1 = gets.chomp
    puts "Enter player 2 name:"
    name2 = gets.chomp
    @player1 = Player.new(name1,:x)
    @player2 = Player.new(name2,:o)
    reset_board
  end

  def reset_board
    @board = [[' ',' ',' '],[' ',' ',' '],[' ',' ',' ']]
  end

  def print_board
    puts '  ' + @board[0].join(' | ')
    puts " ---+---+---"
    puts '  ' + @board[1].join(' | ')
    puts " ---+---+---"
    puts '  ' + @board[2].join(' | ')
  end

  def place_move(piece, x, y)
    @board[x][y] == ' ' ? @board[x][y] = piece : "Invalid"
  end

  def valid_input
    puts "Where would you like to go? Enter row and column number 1-3 as such: 'x,y' or even 'xy'."
    while true
      input = gets.chomp.scan(/\d/)
      break if (input.select {|n| n.to_i >0 && n.to_i<4}.length) == 2
      puts "Invalid Entry. Please enter the row and column number again."
    end
    input = input.map {|n| n.to_i - 1}
  end

  def player_turn(player)
    loop do
      print_board
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
        print_board
        puts "#{player.name} wins!"
        return play_again?
      end
      turn += 1
    end
    print_board
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

end

game = TicTacToe.new.play
