require 'oystercard'

describe Oystercard do
  before { @default_balance = 5 }
  before { @minimum_fare = described_class::MINIMUM_FARE }
  before { @maximum_balance = described_class::MAXIMUM_BALANCE }
  before { @top_up_cap = @maximum_balance - @default_balance }
  before { @arbitrary_topup = rand(@minimum_fare..@top_up_cap) }
  subject(:card) { described_class.new(@default_balance) }
  let(:station) { double :station }

  describe '#initialize' do
    it 'creates a card with a default balance' do
      expect(card.balance).to eq @default_balance
    end

    it 'initializes a card with an empty list of journeys' do
      expect(card.journeys).to be_empty
    end
  end

  describe '#top_up' do
    it 'does not allow card to hold more than the limit' do
      topup = proc { card.top_up(@maximum_balance + 1) }
      error_message = "Maximum limit £#{@maximum_balance} exceeded"
      expect { topup.call }.to raise_error(error_message)
    end

    it 'tops up the card with the given amount' do
      card.top_up(@arbitrary_topup)
      expect(card.balance).to eq @arbitrary_topup + @default_balance
    end
  end

  describe '#touch_in' do
    it 'stores the entry station of the current journey' do
      card.touch_in(station)
      expect(card.entry_station).to eq station
    end

    context 'insufficient funds' do
      before { @default_balance = 0 }
      it 'raises an error if the card has insufficient funds' do
        error_message = 'Insufficient funds, please top up'
        expect { card.touch_in(station) }.to raise_error(error_message)
      end
    end

    context 'sufficient funds' do
      before do
        card.top_up(@minimum_fare)
        card.touch_in(station)
      end

      it { should be_in_journey }
    end
  end

  describe '#touch_out' do
    before { card.touch_in(station) }

    it 'should not be in journey after touching out' do
      card.touch_out(station)
      expect(card.in_journey?).to be_falsey
    end

    it 'reduces the balance on touch out by the minimum fare' do
      touch_out = proc { card.touch_out(station) }
      expect { touch_out.call }.to change { card.balance }.by(-@minimum_fare)
    end

    it 'sets the entry station to nil' do
      card.touch_out(station)
      expect(card.entry_station).to eq nil
    end
  end

  describe '#in_journey?' do
    it 'returns false for a new card' do
      should_not be_in_journey
    end
  end

  context 'after completing the journey' do
    before { card.touch_in(:waterloo) }
    before { card.touch_out(:bank) }

    it 'is expected to create one journey' do
      expect(card.journeys).to eq [{ waterloo: :bank }]
    end
  end
end
