# frozen_string_literal: true

RSpec.describe Rb21::Card do
  let(:normal) { Rb21::Card::NORMALS.sample }
  let(:suit) { Rb21::Card::SUITS.sample }
  let(:ten_cards) { Rb21::Card::TEN_VALUES }
  let(:ace) { Rb21::Card::ACE }

  it "has a name" do
    expect(Rb21::Card.new(normal, suit).name).to be(normal)
  end

  it "requires a valid name" do
    expect { Rb21::Card.new("bad", suit) }.to raise_error(ArgumentError)
  end

  it "requires a valid suit" do
    expect { Rb21::Card.new(normal, "bad") }.to raise_error(ArgumentError)
  end

  it "has a suite" do
    expect(Rb21::Card.new(normal, suit).suit).to be(suit)
  end

  it "has a value equal to normal values" do
    Rb21::Card::NORMALS.each do |value|
      expect(Rb21::Card.new(value.to_s, suit).value).to eq([value.to_i])
    end
  end

  it "has a value for ten for 10s, jacks, queens, and kings" do
    ten_cards.each do |card_name|
      expect(Rb21::Card.new(card_name, suit).value).to eq([10])
    end
  end

  it "has a value of 1 or 11 for aces" do
    expect(Rb21::Card.new(ace, suit).value).to eq([1, 11])
  end
end
