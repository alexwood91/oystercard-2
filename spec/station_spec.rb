require 'station'

describe Station do

  it "has a name" do
    station = Station.new("Euston", "Zone 1")
    expect(station.name).to eq "Euston"
  end

  it "has a zone" do
    station = Station.new("Euston", "Zone 1")
    expect(station.zone).to eq "Zone 1"
  end

end
