require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'
RSpec.describe Player do

    it "creates player" do
      card1 = Card.new(:diamond, 'Queen', 12)
      card2 = Card.new(:spade, '3', 3)
      card3 = Card.new(:heart, 'Ace', 14)
      deck = Deck.new([card1, card2, card3])
      player = Player.new('Clarisa', deck)
      expect(player).to be_an_instance_of(Player)
    end

    it "#has_lost?" do
      card1 = Card.new(:diamond, 'Queen', 12)
      card2 = Card.new(:spade, '3', 3)
      card3 = Card.new(:heart, 'Ace', 14)
      deck = Deck.new([card1, card2, card3])
      player = Player.new('Clarisa', deck)
      expect(player.has_lost?).to eq(false)
      player.deck.remove_card
      player.deck.remove_card
      player.deck.remove_card
      expect(player.has_lost?).to eq(true)
      player.deck.cards << card1
      expect(player.has_lost?).to eq(false)
    end
end
