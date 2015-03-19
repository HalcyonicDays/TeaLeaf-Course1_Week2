class Player
  attr_accessor :choice
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    #{name}
  end
end
#-------------------------------------
class Human < Player

  def take_turn
     begin
      puts "Please select from one of the available squares: (1-9)"
      choice = get.chomp.to_i
    end until tictactoe.available_squares.include?(choice)
  end

end
#-------------------------------------
class Computer < Player
  
  def take_turn
    chocie = tictactoe.available_squares.sample
  end

end
#------------------------------------------------------------------------------------------------------------------------------------------------
class Cell

  attr_accessor :cell

  def initialize(value)
    @cell = value
  end

  def to_s
    cell
  end

  def select_square

  end

end


class Grid

  attr_accessor :grid
  attr_reader :player1, :player2

  def initialize(humans = 1)
    @grid = {}
    1.upto(9) { |position|  @grid[position] = Cell.new(" ") }
    puts "Let's play Tic-Tac-Toe!"
    @player1 = Human.new("Elya")
    @player2 = Computer.new("R2D2") unless humans == 2
    @player2 = Human.new("Challenger") if humans == 2
  end

  def to_s
    #system 'clear'
    puts "     |     |     "  
    puts "  #{grid[1]}  |  #{grid[2]}  |  #{grid[3]}  "
    puts "    1|    2|    3"
    puts "-----+-----+-----"
    puts "     |     |     "  
    puts "  #{grid[4]}  |  #{grid[5]}  |  #{grid[6]}  "
    puts "    4|    5|    6"
    puts "-----+-----+-----"
    puts "     |     |     "  
    puts "  #{grid[7]}  |  #{grid[8]}  |  #{grid[9]}  "
    puts "    7|    8|    9"
  end

  def available_squares
    grid.select { |key, val| val == " " }.keys
  end

  def start_game
    #grid[player1.take_turn(grid)] = "X"
    #grid[player2.take_turn(grid)] = "ø"
    puts "Current players are: #{player1.name} and #{player2.name}"
  end

end
  
  puts "How many human players, 1 or 2? (default 1): "
  number_of_players = gets.chomp.to_i  
  
  [1, 2].include?(number_of_players) ? tictactoe = Grid.new(number_of_players) : tictactoe = Grid.new
  tictactoe.start_game