require './lib/oystercard'

# Test journey storage functionality
card = Oystercard.new
card.top_up(20)
card.touch_in("London Euston")
card.touch_out("Kings Cross")

p card.journeys

# End of test
