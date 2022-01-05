class Oystercard

  attr_reader :balance, :entry_station
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum limit of £#{LIMIT} has been reached" if @balance + amount > LIMIT
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM
    @entry_station = station
  end

  def touch_out
    deduct
    @entry_station = nil
  end

  private

  def deduct
    @balance -= MINIMUM
  end

end