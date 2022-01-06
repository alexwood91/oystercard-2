class Oystercard

  attr_reader :balance
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Maximum limit of £#{LIMIT} has been reached" if @balance + amount > LIMIT
    @balance += amount
  end
  
  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM
 end

  def touch_out(station)
    deduct

  end

  private

  def deduct
    @balance -= MINIMUM
  end

end