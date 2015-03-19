class Hand

  include Comparable
  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == "p" && another_hand.value == "r" || @value == "r" && another_hand.value == "s" || @value == "s" && another_hand.value == "p") 
      1
    else
      -1
    end
  end

  def to_s
    value
  end

end


class Player
  attr_accessor :choice, :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    "#{name} choses #{hand}"
  end
end

class Human < Player

  def pick_hand
     begin
      puts "Choose: (R / P / S)"
      c = gets.chomp.downcase
    end until Janken::CHOICES.include?(c)
    self.hand = Hand.new(c)
  end
end

class Computer < Player
  
  def pick_hand
    self.hand = Hand.new(Janken::CHOICES.sample)
  end

end

class Janken
CHOICES = %w(r p s)

attr_reader :player, :computer

  def initialize
    @player = Human.new("Real Person")
    @computer = Computer.new("R2D2")
  end

  def compare_hands
    if player.hand > computer.hand
      "#{player.name} won!"
    elsif player.hand < computer.hand
      "#{computer.name} won!"
    end
  end

  def play
    computer.pick_hand
    player.pick_hand
    puts player.hand == computer.hand ? "This game is a tie" : compare_hands

    puts player
    puts computer

  end

end

tictactoe =Janken.new

begin
  tictactoe.play
  puts "Play again? Y / N"
  answer = gets.chomp.downcase
end until answer != "y"
