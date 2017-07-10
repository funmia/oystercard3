require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new }

  describe '#initialize' do
    it 'creates a card with a zero balance' do
      expect(card.balance).to eq 0
    end
  end

end
