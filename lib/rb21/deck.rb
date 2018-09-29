# frozen_string_literal: true

module Rb21
  class Deck
    attr_reader :cards

    def initialize
      @cards = []
      @discarded = []
      build
    end

    def draw
      raise "Draw pile is empty" if empty?
      (@discarded << @cards.shift).last
    end

    def empty?
      @cards.size.zero?
    end

    def reshuffle
      raise "The deck is not empty" unless @cards.size.zero?
      @cards = @discarded
      @discarded = []
      @cards.shuffle!
    end

    private

    def build
      Card::SUITS.each do |suit|
        Card::ALL_NAMES.each do |name|
          @cards << Card.new(name, suit)
        end
      end
      @cards.shuffle!
    end
  end
end
