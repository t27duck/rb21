# frozen_string_literal: true

RSpec.describe Rb21::Hand do
  let(:hand) { Rb21::Hand.new }
  let(:card) { Rb21::Card.new("2", "Hearts") }
  let(:ace) { Rb21::Card.new("Ace", "Hearts") }
  let(:ten) { Rb21::Card.new("10", "Hearts") }
  let(:eight) { Rb21::Card.new("8", "Hearts") }

  it "has a no cards by default" do
    expect(hand.cards).to be_empty
  end

  it "can hold cards that it receives" do
    hand.receive(card)
    expect(hand.cards).to_not be_empty
    expect(hand.cards.first).to be(card)
  end

  it "can clear its held cards" do
    hand.receive(card)
    hand.clear
    expect(hand.cards).to be_empty
  end

  context "#value" do
    it "is 0 without any cards" do
      expect(hand.value).to eq(0)
    end

    it "has the value of the card given" do
      hand.receive(card)
      expect(hand.value).to eq(card.value.first)
    end

    it "adds up the values of the cards given" do
      hand.receive(card)
      hand.receive(card)
      expect(hand.value).to eq(card.value.first * 2)
    end

    it "is allowed to go over the limit" do
      hand.receive(ten)
      hand.receive(ten)
      hand.receive(eight)
      expect(hand.value).to be > Rb21::Hand::LIMIT
    end

    context "with ace in place" do
      it "does not go over 21 if there are two or more aces" do
        hand.receive(ace)
        hand.receive(ace)
        expect(hand.value).to eq(12)

        hand.clear

        hand.receive(ace)
        hand.receive(ace)
        hand.receive(ace)
        expect(hand.value).to eq(13)

        hand.clear

        hand.receive(ace)
        hand.receive(eight)
        hand.receive(ace)
        expect(hand.value).to eq(20)
      end

      it "takes the lower value of the ace if total goes over 21" do
        hand.receive(eight)
        hand.receive(ace)
        hand.receive(eight)
        expect(hand.value).to eq(17)
      end
    end

    it "is a blackjack if an ace and a ten value card are the only things in the hand" do
      hand.receive(ace)
      hand.receive(card)
      expect(hand.blackjack?).to be(false)

      hand.clear

      Rb21::Card::TEN_VALUES.each do |value|
        hand.receive(ace)
        hand.receive(Rb21::Card.new(value, "Hearts"))
        expect(hand.blackjack?).to be(true)
        hand.clear
      end
    end

    it "is busted if value is over the limit" do
      hand.receive(ace)
      hand.receive(card)
      expect(hand.busted?).to be(false)
      hand.clear

      hand.receive(ace)
      hand.receive(ten)
      expect(hand.busted?).to be(false)
      hand.clear

      hand.receive(ten)
      hand.receive(eight)
      hand.receive(ten)
      expect(hand.busted?).to be(true)
    end
  end
end
