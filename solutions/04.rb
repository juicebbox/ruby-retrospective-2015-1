RANKS = (1..14).to_a
HIGH_CARDS = {jack: 11, queen: 12, king: 13, ace: 14}
SUITS ={spades: 0, hearts: 1, diamonds: 2, clubs: 3}

class Card
  attr_accessor :rank, :suit, :rank_number

  def initialize(rank = 2, suit = :spades)
    @rank = rank
    @rank_number = self.get_rank_number
    @suit = suit
  end

  def get_rank_number
    if HIGH_CARDS.include?(@rank) then
      return HIGH_CARDS[@rank]
    elsif @rank.class != "Symbol" && (@rank >= 2 || @rank <= 10) then
      return @rank
    end
  end
  def ==(other)
    if self.suit != other.suit then return false end
    if self.rank != other.rank then return false end
    true
  end
  def <(other)
    if self == other then return false end
    if self.rank_number < other.rank_number then return true end
    if SUITS[self.suit] < SUITS[other.suit] then return true end
    return false
  end
  def to_s
    rank_string = rank.to_s.capitalize
    suit_string = suit.to_s.capitalize
    rank_string + " of " + suit_string
  end
end

class Deck
  include Enumerable

  attr_accessor :hand
  attr_accessor :deck

  def initialize(deck = self.get_deck)
    @deck = deck
    @hand = []
    @hand_size = 26
  end

  def each
    yield
  end

  def get_deck
    basic_deck = Array.new()
    (0..3).each do |suit|
      (1..13).each do |rank|
        basic_deck << Card.new(get_rank(rank), SUITS.keys[suit])
      end
    end
    @deck = basic_deck
  end

  def get_rank(rank)
    if rank < 10 then
      return RANKS[rank]
    else
      return HIGH_CARDS.keys[rank - 10]
    end
  end

  def size
    @deck.count
  end

  def draw_top_card(deck)
  end

  def draw_bottom_card(deck)
  end

  def top_card
  end

  def bottom_card
  end

  def shuffle
    @deck.shuffle
  end

  def sort
    @deck.sort{ |first, second|
      first.suit <=> second.suit
    }
    @deck.reverse
  end

  def to_s
    @deck.each{|card| p card.to_s}
  end

  def get_hand
    hand = Array.new
    (0..(@hand_size - 1)).each {|card|
      hand << @deck[card]
    }
    hand
  end
  def deal
    Deck.new(self.get_hand)
  end
  def allow_face_up?
    false
  end
  def is_hand?
    self.size <= @hand_size
  end
end

class WarDeck < Deck
  attr_accessor :deck
  def initialize(deck = self.get_deck)
    super
  end

  def play_card
    @deck.delete(@deck[Random.rand(self.size)])
  end
  def allow_face_up?
    self.deck.size < 3
  end
  def deal
    WarDeck.new(get_hand)
  end
end

class BeloteDeck < Deck
  def initialize(deck = self.get_deck)
    super
    @hand_size = 8
    @deck = deck.delete_if{|card|
      if card < Card.new(7,:spades) then
        RANKS[card.rank] < 8
      end
    }
  end

  def deal
    BeloteDeck.new(get_hand)
  end
  def highest_of_suit(suit)
    found_card = false
    highest_of_suit = Card.new(1,suit)
    @deck.each {|card|
      highest_of_suit = higher_card_check(highest_of_suit, card, suit)
    }
    return nil unless Card.new(1,suit) < highest_of_suit
    highest_of_suit
  end

  def higher_card_check(current_high, new_card, suit)
    if current_high < new_card && new_card.suit == suit then
      current_high = new_card
    end
    current_high
  end

  def belote?
  end
  def tierce?
  end
  def quarte?
  end
  def quint?
  end
  def carre_of_jacks?
  end
  def carre_of_nines?
  end
  def carre_of_aces?
  end
end

class SixtySixDeck < Deck
  def initialize(deck = self.get_deck)
    super
    @hand_size = 6
  end
  def deal
    SixtySixDeck.new(get_hand)
  end
  def twenty?
  end
  def forty?
  end
end
