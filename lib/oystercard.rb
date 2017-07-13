require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @log = JourneyLog.new
  end

  def top_up(amount)
    limit_error = "Maximum limit £#{MAXIMUM_BALANCE} exceeded"
    raise(limit_error) if exceeds_limit?(amount)
    credit(amount)
  end

  def touch_in(station)
    if in_journey?
      @log.add_journey
      @in_journey = false
      deduct(@log.last_fare)
    else
      raise('Insufficient funds, please top up') if insufficient_funds?
      @in_journey = true
      @log.start(station)
    end
  end

  def touch_out(station)
    @in_journey = false
    @log.finish(station)
    @log.add_journey
    deduct(@log.last_fare)
  end

  def in_journey?
    @in_journey
  end

  def journeys
    @log.journeys
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

end
