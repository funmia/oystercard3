
class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise("Maximum limit £#{MAXIMUM_BALANCE} exceeded") if exceeds_limit?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end
  private

  def exceeds_limit?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end
end
