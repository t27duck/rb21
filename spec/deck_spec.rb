# frozen_string_literal: true

RSpec.describe Rb21::Deck do
  let(:deck_size) { Rb21::Card::SUITS.size * Rb21::Card::ALL_NAMES.size }
  let(:deck) { Rb21::Deck.new }

  def drain_deck
    deck_size.times do
      deck.draw
    end
  end

  def drain_deck_but_1
    (deck_size - 1).times do
      deck.draw
    end
  end

  it "builds a deck of cards" do
    expect(Rb21::Deck.new.cards).to all(be_a(Rb21::Card))
  end

  it "builds the correct number of cards" do
    expect(Rb21::Deck.new.cards.size).to eq(deck_size)
  end

  it "draws and returns a Card" do
    expect(deck.draw).to be_a(Rb21::Card)
  end

  it "raises an exception if you try to draw a card and no more are left" do
    drain_deck
    expect { deck.draw }.to raise_error(RuntimeError)
  end

  it "is empty is there are no more drawable cards" do
    drain_deck
    expect(deck.empty?).to be(true)
  end

  it "is not empty is there is at least one drawable card" do
    drain_deck_but_1
    expect(deck.empty?).to be(false)
  end

  it "shuffles an empty deck to allow more drawing" do
    drain_deck
    deck.reshuffle
    expect(deck.draw).to be_a(Rb21::Card)
  end

  it "prevents reshuffling a non-empty deck" do
    drain_deck_but_1
    expect { deck.reshuffle }.to raise_error(RuntimeError)
  end
end
