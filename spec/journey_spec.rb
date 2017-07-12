require 'journey'

describe Journey do

  subject(:journey) { described_class.new(entry_station) }
  let(:entry_station) { :moorgate }
  let(:other_station) {double :other_station}

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

    context 'when given an exit station' do
      before do
        journey.finish(other_station)
      end

      it 'calculates a fare' do
        expect(journey.fare).to eq 1
      end

      it 'knows if a journey is complete' do
        expect(journey).to be_complete
      end

      it "returns itself when exiting a journey" do
        expect(subject.finish(other_station)).to eq({entry_station => other_station})
      end
    end
  end
end
