# frozen_string_literal: true

module Rb21
  class Hand
    LIMIT = 21
    attr_reader :cards

    def initialize
      @cards = []
    end

    def receive(card)
      @cards << card
      @cards.sort_by! { |c| c.value.size }
      card
    end

    def clear
      @cards.clear
    end

    def value
      val = 0
      @cards.map { |card| card.value.sort.reverse }.each do |possible_values|
        possible_values.each_with_index do |possible_value, i|
          if i + 1 == possible_values.size || val + possible_value <= LIMIT
            val += possible_value
            break
          end
        end
      end
      val
    end

    def busted?
      value > LIMIT
    end

    def blackjack?
      names = @cards.map(&:name)
      @cards.size == 2 &&
        names.include?(Card::ACE) &&
        (names & Card::TEN_VALUES).size.positive?
    end
  end
end
