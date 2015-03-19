class Card

attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

end



class Deck

  attr_accessor :cards, :discard

  def initialize(suits, value_range, number_of_decks=1)
    @cards = []
    @discard = []
    suits.each do |suit|
      value_range.each do |value|
        @cards << Card.new(suit, value)
      end
    end
    @cards = @cards * number_of_decks
  end

  def mix_up
    cards.shuffle!
  end

  def deal_card(location = @discard)
    location << cards.pop
  end

end

class Player

attr_reader :name
attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def take_turn

  end

  def score

  end

  def has_won?

  end

end






