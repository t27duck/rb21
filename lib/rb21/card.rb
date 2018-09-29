# frozen_string_literal: true

module Rb21
  class Card
    SUITS = %w[Clubs Diamonds Hearts Spades].freeze
    FACES = %w[Jack Queen King].freeze
    NORMALS = (2..9).map(&:to_s).freeze
    ACE = "Ace"
    TEN_VALUES = (["10"] + FACES).freeze
    ALL_NAMES = (TEN_VALUES + NORMALS + [ACE]).freeze
    attr_reader :name, :suit

    def initialize(name, suit)
      raise ArgumentError, "Invalid name" unless ALL_NAMES.include?(name)
      raise ArgumentError, "Invalid suit" unless SUITS.include?(suit)
      @name = name
      @suit = suit
    end

    def value
      case @name
      when ACE
        [1, 11]
      when *TEN_VALUES
        [10]
      else
        [@name.to_i]
      end
    end
  end
end
