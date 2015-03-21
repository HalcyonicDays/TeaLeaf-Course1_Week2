class Player
  attr_reader :name, :marker

  def initialize(n, mark)
    @name = n
    @marker = mark
  end

  def to_s
    "#{name}"
  end
end
#-------------------------------------
class Human < Player

  def take_turn(board, marking)
     begin
      puts "This is the board: #{board}"
      puts "available_squares are #{board.available_squares}"
      puts "Please select from one of the available squares: (1-9)"
      choice = gets.chomp.to_i
    end until board.available_squares.include?(choice)
    board.occupy_square(choice, marking)
  end

end
#-------------------------------------
class Computer < Player
  
  def take_turn(grid, marking)
    choice = grid.available_squares.sample
    grid.occupy_square(choice, marking)
  end

end
#------------------------------------------------------------------------------------------------------------------------------------------------
class TicTacToeGame

  WIN_CONDITIONS = %w(123 456 789 147 258 369 159 357)
  attr_accessor :board, :currentplayer, :winner
  attr_reader :player1, :player2

  def initialize(humans = 1, p1_name, p2_name)
    puts "Let's play Tic-Tac-Toe!"
    @board = Grid.new(3, 3)
    @player1 = Human.new(p1_name, "X")
    @player2 = Computer.new(p2_name, "ø") unless humans == 2
    @player2 = Human.new(p2_name, "ø") if humans == 2
  end

  def take_turn(player)
    return if game_ends?
    @currentplayer = player
    currentplayer.take_turn(board, currentplayer.marker)
  end

  def play_game
    begin
      puts "current player is: #{currentplayer}"
      take_turn(player1)
      puts "current player is: #{currentplayer}"
      take_turn(player2)
    end until game_ends?
    puts board
    if board.available_squares == [] && winner == nil then
      puts "This game is a tie."
    else
      puts "Congratulations, #{winner}, you have won!"
    end      
  end

  def game_ends?
    end_game = false
    WIN_CONDITIONS.each do |combination|
      test_condition = combination.split("")
      if board.cells[test_condition[0].to_i] != " "
        if board.cells[test_condition[0].to_i] == board.cells[test_condition[1].to_i] && board.cells[test_condition[0].to_i] == board.cells[test_condition[2].to_i]
          end_game = true
          @winner = currentplayer.name
        end
      end
    end
    return true if board.available_squares == []
    end_game
  end
end

class Grid

  attr_reader :width, :height
  attr_accessor :cells

  def initialize(x = 3, y = 3)
    @width  = x
    @height = y
    @cells = {}
    1.upto(x*y) { |position|  cells[position] = " " }
    puts "Your #{width} by #{height} grid is ready: #{self}"
  end

  def go_across(yheight, chars)
    board = ""
    board << "\n#{chars[-1]}"
    1.upto(width) do |xlength| 
      key = (xlength + (yheight-1)*width)
      board << chars
    end
    board
  end
  
  def draw_board
    board = ""
    #board << "\n -----+-----+-----"
    1.upto(height) do |yheight|
      board << go_across(yheight,"-----+")
      board << go_across(yheight,"     |")
      
      board << "\n|"
      1.upto(width) do |xlength| 
        key = (xlength + (yheight-1)*width)
        board << "  #{cells[key]}  |"
      end
      
      board << "\n|"
      1.upto(width) do |xlength| 
        key = (xlength + (yheight-1)*width)
        if cells[key] == " "
          (5-(key.to_s.length)).times {board << " "}
          board << "#{key}|"
        else
          board << "     |"
        end
      end
    
    end
    board << go_across(0,"-----+")
    board
  end
  
  def to_s
    system 'clear'
    draw_board
  end
  
  def available_squares
    cells.select { |position, value| value == " " }.keys
  end

  def occupy_square(position, marking)
    cells[position] = marking
  end

end

puts "Would you like to play Tic-Tac-Toe? (Y / N)"
answer = gets.chomp.downcase[0]

while answer == "y"
  puts "How many human players, 1 or 2? (default 1): "
  number_of_players = gets.chomp.to_i  
  puts "what is Player 1's name?"
  p1_name = gets.chomp.downcase.capitalize

  case number_of_players
  when 2
    puts "what is Player 1's name?"
    p2_name = gets.chomp.downcase.capitalize
    tictactoe = TicTacToeGame.new(number_of_players, p1_name, p2_name)
  else
    tictactoe = TicTacToeGame.new(number_of_players, p1_name, "R2D2")
  end

  tictactoe.play_game
  
  puts "Would you like to play again? (Y / N)"
  answer = gets.chomp.downcase[0]  
end
