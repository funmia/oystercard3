class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    limit_error = "Maximum limit £#{MAXIMUM_BALANCE} exceeded"
    raise(limit_error) if exceeds_limit?(amount)
    credit(amount)
  end

  def touch_in(station)
    raise('Insufficient funds, please top up') if insufficient_funds?
    in_journey?
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    add_journey(make_journey(@entry_station, station))
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def exceeds_limit?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def credit(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def make_journey(entry, exit)
    { entry => exit }
  end

  def add_journey(journey)
    @journeys << journey
  end
end
