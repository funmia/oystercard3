require 'station'

describe Station do

subject { described_class.new(:bank, 1) }

  describe '#initialize' do

    it 'creates a station with a name' do
      expect(subject.name).to eq(:bank)
    end
    it 'creates a station with a zone' do
      expect(subject.zone).to eq 1
    end
  end
end
