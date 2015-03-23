#!/usr/local/bin/ruby

module BlackJack
  SUITS  = %w(♥ ♦ ♠ ♣)
  VALUES = %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)
  BLACKJACK    = 21
  DEALER_LIMIT = 17
  attr_accessor :player1, :player2, :discard_pile
  
  def initialize(p1_name)
    @player1 = Human.new(p1_name)
    @player2 = Computer.new("The Dealer")
    @discard_pile = Discard.new("Discard Pile")
  end

  def bust?(player)
    total_score(player) > BLACKJACK
  end

  def blackjack?(player)
    total_score(player) == BLACKJACK
  end

  def total_score(players_hand)
    point_total = 0
    total_aces = 0
    players_hand.each { |card| total_aces += card.value.count("A") }

    players_hand.each do |card|
      point_total += card.value.to_i
      point_total += 10 if card.value.to_i == 0 unless card.value == "Ace"
    end

    point_total += total_aces
    total_aces.times do
      (point_total + 10) > BLACKJACK  ? point_total : point_total += 10
    end
    point_total
  end

end
#-----------------------------------
class Player

attr_reader :name
attr_accessor :hand

  def initialize(player_name)
    @name = player_name
    @hand = []
  end

  def hand
    @hand
  end

  def score

  end

  def has_won?

  end

  def to_s
    "#{name}"
  end

end

class Human < Player

  def initialize(player_name)
    super
    puts "Welcome, #{name}"
  end

  def take_turn(deck)
    puts "You have a total of #{total_score(player1.hand)}.  Will you (H)it or (S)tay?"
    begin
      choice = gets.chomp.downcase[0]
    end until %w(h s).include?(choice)
    self.hand << deck.deal_card if choice = h 
    

      take_turn(deck) 

  end

end

class Computer < Player

  def take_turn

  end


end

class Discard < Player

  def reveal
    puts hand
  end

  def to_s
    hand.reverse
  end
end
#-----------------------------------

class Deck
# ♥ ♦ ♠ ♣ ★ saved for reuse with other Deck class uses.
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
    mix_up!
  end

  def mix_up!
    cards.shuffle!
  end

  def deal_card
    puts "No more cards in the deck!" if cards.length == 0
    cards.pop unless cards.length == 0
  end

  def size
    cards.select { |card| card}.size
  end

end

class Card

attr_accessor :suit, :value, :face_value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{value} of #{suit}"  
  end

end

class CardGame
  include BlackJack
  attr_accessor :deck

  def initialize
    puts "What is your name?"
    name = gets.chomp.capitalize
    super(name)
    
    puts "How many decks should be used? (1-6): "
    answer = gets.chomp.to_i
    number_of_decks = (1..6).include?(answer) ? answer : 1
    @deck = Deck.new(SUITS, VALUES, number_of_decks)
    initial_deal
  end

  def initial_deal
    2.times do 
      deck.deal_card(player1)
      deck.deal_card(player2)
      puts "#{player1} has drawn a #{player1.hand.last}"
    end
    puts "#{player2} has drawn a #{player2.hand.last}"
    puts "#{player1}'s total is #{total_score(player1.hand)}."
    puts "#{player2}'s total is #{total_score([player2.hand.last])}."
  end

  def play
    player1.take_turn(deck)
    player2.take_turn(deck)
  end

end

objack = CardGame.new
objack.play

