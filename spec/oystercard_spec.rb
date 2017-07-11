require 'oystercard'

describe Oystercard do
  before {@default_balance = 5}
  subject(:card) { described_class.new(@default_balance) }
  ARBITRARY_TOP_UP = 10
  MINIMUM_FARE = 1
  let(:station) {double :station}

  describe '#initialize' do
    it 'creates a card with a default balance' do
      expect(card.balance).to eq @default_balance
    end
  end

  describe '#top_up' do
    it 'does not allow card to hold more than the limit' do
      expect { card.top_up(described_class::MAXIMUM_BALANCE + 1) }
        .to raise_error("Maximum limit £#{described_class::MAXIMUM_BALANCE} exceeded")
    end

    it 'tops up the card with the given amount' do
      card.top_up(ARBITRARY_TOP_UP)
      expect(card.balance).to eq ARBITRARY_TOP_UP + @default_balance
    end
  end

  describe '#touch_in' do
    it "stores the entry station of the current journey" do
      card.touch_in(station)
      expect(card.entry_station).to eq station
    end
    context "insufficient funds" do
      before {@default_balance = 0}
      it 'raises an error if the card has insufficient funds' do
        expect{card.touch_in(station)}.to raise_error("Insufficient funds, please top up")
      end
    end
    context "sufficient funds" do
      before do
        card.top_up(described_class::MINIMUM_FARE)
        card.touch_in(station)
      end
      it { should be_in_journey }
    end

  end

  describe '#touch_out' do
    before { card.touch_in(station) }
    it "should not be in journey after touching out" do
      card.touch_out
      expect(card.in_journey?).to eq false
    end
    it "reduces the balance on touch out by the minimum fare" do
      expect{card.touch_out}.to change{card.balance}.by(-MINIMUM_FARE)
    end
    it "sets the entry station to nil" do
      card.touch_out
      expect(card.entry_station).to eq nil
    end
  end

  describe '#in_journey?' do
    it 'returns false for a new card' do
       should_not be_in_journey
    end
  end
end
