require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require 'pry'
RSpec.describe Turn do
  # describe "card_setup" do
    before :each do
      @card1 = Card.new(:heart, 'Jack', 11)
      @card2 = Card.new(:heart, '10', 10)
      @card3 = Card.new(:heart, '9', 9)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card5 = Card.new(:heart, '8', 8)
      @card6 = Card.new(:diamond, 'Queen', 12)
      @card7 = Card.new(:heart, '3', 3)
      @card8 = Card.new(:diamond, '2', 2)
      @deck1 = Deck.new([@card1, @card2, @card5, @card8])
      @deck2 = Deck.new([@card3, @card4, @card6, @card7])
      @player1 = Player.new("Megan", @deck1)
      @player2 = Player.new("Aurora", @deck2)
    end

  it "creates turn" do
    turn = Turn.new(@player1, @player2)
    expect(turn).to be_an_instance_of(Turn)
  end

  it "determines type" do
    turn = Turn.new(@player1, @player2)
    expect(turn.type).to eq(:basic)
  end

  it "determines winner" do
    turn = Turn.new(@player1, @player2)
    expect(turn.winner).to eq(@player1)
  end

  it "#pile_cards" do
    turn = Turn.new(@player1, @player2)
    winner = turn.winner
    turn.pile_cards
    expect(turn.spoils_of_war).to eq([@card1,@card3])
  end

  it "#award_spoils" do
    turn = Turn.new(@player1, @player2)
    winner = turn.winner
    turn.pile_cards
    turn.award_spoils(winner)
    expect(@player1.deck.cards).to eq([@card2, @card5, @card8, @card1, @card3])
  end

  it "goes to war" do
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card4, card3, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    expect(turn.type).to eq(:war)
    winner = turn.winner
    expect(turn.winner).to eq(player2)
    turn.pile_cards
    turn.spoils_of_war
    turn.award_spoils(winner)
    expect(player1.deck.cards).to eq([card8])
    expect(player2.deck.cards).to eq([card7, card1, card4, card2, card3, card5, card6])
  end

  it "mutually destructs" do
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, '8', 8)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card4, card3, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    expect(turn.type).to eq(:mutually_assured_destruction)
    winner = turn.winner
    expect(turn.winner).to eq("No Winner")
    turn.pile_cards
    turn.spoils_of_war
    turn.award_spoils(winner)
    expect(player1.deck.cards).to eq([card8])
    expect(player2.deck.cards).to eq([card7])
  end
end
