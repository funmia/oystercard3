
class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :entry_station

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    raise("Maximum limit £#{MAXIMUM_BALANCE} exceeded") if exceeds_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail("Insufficient funds, please top up") if insufficient_funds?
    in_journey?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    in_journey?
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

  def deduct(fare)
    @balance -= fare
  end

end
