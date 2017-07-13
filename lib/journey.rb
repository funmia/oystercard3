require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  attr_reader :entry_station, :other_station

  def initialize
    @entry_station = nil
    @exit_station = nil
    @fare = PENALTY_FARE
  end

  def start(entry_station)
     @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    fare 
    self
  end

  def fare
    if complete?
      @fare = MINIMUM_FARE
    else
      @fare = PENALTY_FARE
    end
    @fare
  end

  def complete?
    @entry_station != nil and @exit_station != nil
  end

end
