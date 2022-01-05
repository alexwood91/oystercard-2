require "oystercard"

describe Oystercard do

  let(:station) { double :station }
  let(:another_station) { double :another_station }

  it "is initially not in a journey" do
    expect(subject.in_journey?).to be false
  end

  describe "balance management" do
    it "is able to store the customers balance" do
      expect(subject.balance).to eq(0)
    end
  
    it { should respond_to(:top_up).with(1).argument }
  
    it "increases the balance by the top up value" do
      expect { subject.top_up 5 }.to change { subject.balance }.by 5
    end
  
    it "maximum limit reached" do
      expect{ subject.top_up(100) }.to raise_error "Maximum limit of £#{Oystercard::LIMIT} has been reached"
    end  
  end
  
  describe "touch in method" do
    it "can touch in" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "will not touch in if card has below minimum balance" do
      expect{ subject.touch_in(station) }.to raise_error "Insufficient funds"
    end

    it "stores the station when touch in" do
      subject.top_up(Oystercard::LIMIT)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end
  
  describe "touch out method" do
    it "can touch out" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(another_station)
      expect(subject).to_not be_in_journey
    end

    it "reduces the balance by the minimum fare" do
      expect { subject.touch_out(another_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM)
    end

    it "deletes entry station on touch out" do
      subject.top_up(Oystercard::LIMIT)
      subject.touch_in(station)
      subject.touch_out(another_station)
      expect(subject.entry_station).to be nil
    end

    it "stores the exit station" do
      subject.top_up(Oystercard::LIMIT)
      subject.touch_in(station)
      subject.touch_out(another_station)
      expect(subject.exit_station).to eq another_station
    end
  end
  
  describe "journeys" do
    it "initializes with no journeys" do
      expect(subject.journeys).to be_empty
    end

    it "can store a journey" do
      subject.top_up(Oystercard::LIMIT)
      subject.touch_in(station)
      subject.touch_out(another_station)
      journey = {entry: station, exit: another_station}
      
      expect(subject.journeys).to include(journey)

    end
  end

end
