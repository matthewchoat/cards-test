class Card
  attr_accessor :rank, :suit, :value

  def initialize(rank, suit, value)
    self.rank = rank
    self.suit = suit
    self.value = value
  end

  def output_card
      puts "The #{self.rank} of #{self.suit}"
  end

  def self.random_card
      Card.new(rand(10), :spades)
  end
end

class Deck
    def initialize
        @cards = []
        @cards << Card.new(:Ace, :Spades, 1 || 11)
        @cards << Card.new(:Two, :Spades, 2)
        @cards << Card.new(:Three, :Spades, 3)
        @cards << Card.new(:Four, :Spades, 4)
        @cards << Card.new(:Five, :Spades, 5)
        @cards << Card.new(:Six, :Spades, 6)
        @cards << Card.new(:Seven, :Spades, 7)
        @cards << Card.new(:Eight, :Spades, 8)
        @cards << Card.new(:Nine, :Spades, 9)
        @cards << Card.new(:Ten, :Spades, 10)
        @cards << Card.new(:Jack, :Spades, 10)
        @cards << Card.new(:Queen, :Spades, 10)
        @cards << Card.new(:King, :Spades, 10)
        @cards << Card.new(:Ace, :Hearts, 1 || 11)
        @cards << Card.new(:Two, :Hearts, 2)
        @cards << Card.new(:Three, :Hearts, 3)
        @cards << Card.new(:Four, :Hearts, 4)
        @cards << Card.new(:Five, :Hearts, 5)
        @cards << Card.new(:Six, :Hearts, 6)
        @cards << Card.new(:Seven, :Hearts, 7)
        @cards << Card.new(:Eight, :Hearts, 8)
        @cards << Card.new(:Nine, :Hearts, 9)
        @cards << Card.new(:Ten, :Hearts, 10)
        @cards << Card.new(:Jack, :Hearts, 10)
        @cards << Card.new(:Queen, :Hearts, 10)
        @cards << Card.new(:King, :Hearts, 10)
        @cards << Card.new(:Ace, :Diamonds, 1 || 11)
        @cards << Card.new(:Two, :Diamonds, 2)
        @cards << Card.new(:Three, :Diamonds, 3)
        @cards << Card.new(:Four, :Diamonds, 4)
        @cards << Card.new(:Five, :Diamonds, 5)
        @cards << Card.new(:Six, :Diamonds, 6)
        @cards << Card.new(:Seven, :Diamonds, 7)
        @cards << Card.new(:Eight, :Diamonds, 8)
        @cards << Card.new(:Nine, :Diamonds, 9)
        @cards << Card.new(:Ten, :Diamonds, 10)
        @cards << Card.new(:Jack, :Diamonds, 10)
        @cards << Card.new(:Queen, :Diamonds, 10)
        @cards << Card.new(:King, :Diamonds, 10)
        @cards << Card.new(:Ace, :Clubs, 1 || 11)
        @cards << Card.new(:Two, :Clubs, 2)
        @cards << Card.new(:Three, :Clubs, 3)
        @cards << Card.new(:Four, :Clubs, 4)
        @cards << Card.new(:Five, :Clubs, 5)
        @cards << Card.new(:Six, :Clubs, 6)
        @cards << Card.new(:Seven, :Clubs, 7)
        @cards << Card.new(:Eight, :Clubs, 8)
        @cards << Card.new(:Nine, :Clubs, 9)
        @cards << Card.new(:Ten, :Clubs, 10)
        @cards << Card.new(:Jack, :Clubs, 10)
        @cards << Card.new(:Queen, :Clubs, 10)
        @cards << Card.new(:King, :Clubs, 10)
    end

    def shuffle
      @cards.shuffle!
    end

    def deal (number)
      number.times {@cards.shift.output_card}
    end

    def output
      @cards.each do |card|
        card.output_card
    end

  end
end

deck = Deck.new
deck.shuffle
#deck.output
deck.deal(1)

