class Journey

  PENALTY_FARE = 100
  FARE = 1
  attr_reader :entry_station, :exit_station

    def initialize(entry_station: nil)
        @complete = false
        @entry_station = entry_station
    end

    def complete?
        @complete
    end

    def fare
      return PENALTY_FARE if penalty? 
      FARE
    end

    def finish(station)
        @exit_station = station
        @complete = true
        self
    end

    def penalty? 
        (!entry_station || !exit_station)
    end
end
