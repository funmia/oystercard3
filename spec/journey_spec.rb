require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:entry_station) { :moorgate }
  let(:exit_station) {double :other_station}

  before { journey.start(entry_station) }

    it 'knows if a journey is not complete' do
      expect(journey).not_to be_complete
    end

    it 'has a penalty fare by default' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

  context 'when given an entry station' do
    it 'has an entry station' do
      expect(journey.entry_station).to eq entry_station
    end

    it 'returns a penalty fare if no exit station given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it "returns itself when exiting a journey" do
      expect(journey.finish(exit_station)).to eq(journey)
    end

    context 'when given an exit station' do
      before do
        journey.finish(exit_station)
      end

      it 'calculates a fare' do
        expect(journey.fare).to eq 1
      end

      it 'knows if a journey is complete' do
        expect(journey).to be_complete
      end
    end
  end
end
