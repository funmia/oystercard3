require_relative 'oystercard'

class Journey
  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station = nil )
    @entry_station = entry_station
    @exit_station = nil
  end

  def complete?
    if entry_station != nil && exit_station != nil
      true
    else
      false
    end
  end

  def finish(exit_station)
    @exit_station = exit_station
    # fare
    make_journey(entry_station, exit_station)
  end

  def fare
    if entry_station == nil || exit_station == nil
      PENALTY_FARE
    else
      Oystercard::MINIMUM_FARE
    end
  end

  def make_journey(entry_station, exit_station)
    { entry_station => exit_station }
  end

end
