require_relative 'journey'
class JourneyLog

  attr_reader :journeys

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey = journey_class.new
    @journeys = []
  end

  def start(station)
    @journey.start(station)
  end

  def finish(station)
    @journey.finish(station)
  end

  def add_journey
    @journeys << @journey
    @journey = Journey.new
  end

  def last_fare
    @journeys.last.fare
  end
end
