# frozen_string_literal: true

module Rb21
  class Card
    SUITS = %w[Clubs Diamonds Hearts Spades].freeze
    FACES = %w[Jack Queen King].freeze
    NORMALS = (2..10).map(&:to_s).freeze
    ACE = "Ace"
    ALL_NAMES = (FACES + NORMALS + [ACE]).freeze
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
      when *FACES
        [10]
      else
        [@name.to_i]
      end
    end
  end
end
