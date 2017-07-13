require 'journey_log'
describe JourneyLog do

  let(:station){ double :station }
  let(:journey){ double :journey, :entry_station => station, :exit_station => station, :fare => 1, :complete => true } #this may need to have some methods
  subject(:journey_log) {described_class.new }

  describe '#start' do
    it 'starts a journey' do
      expect(journey_log.start(station)).to eq (station)
    end

    it "starts a journey but doesn't store it until complete" do
      journey_log.start(station)
      expect(journey_log.journeys.length).to eq 0
    end

    it 'records a journey' do
      journey_log.start(station)
      journey_log.finish(station)
      journey_log.add_journey
      expect(journey_log.journeys.length).to eq 1
    end
  end
end
