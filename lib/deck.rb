class Deck
  attr_reader :cards

  def initialize(cards)
  @cards = cards
  end

  def rank_of_card_at(card_number)
    if @cards.length < card_number +1
      0
    else
    @cards[card_number].rank
    end
  end

  def high_ranking_cards
    high_ranking_array = []
    @cards.each do |card|
      if card.rank > 11
        high_ranking_array << card
      end
    end
    return high_ranking_array
  end

  def percent_high_ranking
    (high_ranking_cards.length.to_f / @cards.length.to_f).round(2)
  end

  def remove_card
    @cards.shift
  end

end
