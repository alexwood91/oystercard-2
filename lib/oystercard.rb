class Oystercard

  attr_reader :balance
  LIMIT = 90

  def initialize

    @balance = 0

  end

  def top_up(value)

    if @balance + value > LIMIT
      raise "Maximum limit of #{LIMIT} has been reached"
    else
      @balance += value
    end

  end

end