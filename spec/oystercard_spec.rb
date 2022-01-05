require "oystercard"

describe Oystercard do

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

  it "is initially not in a journey" do
    expect(subject.in_journey?).to be false
  end

  it "can touch in" do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  describe "touch out method" do
    it "can touch out" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject).to_not be_in_journey
    end

    it "reduces the balance by the minimum fare" do
      expect { subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM)
    end
  end

  it "will not touch in if card has below minimum balance" do
    expect{ subject.touch_in(station) }.to raise_error "Insufficient funds"
  end

  let(:station) { double :station }

  it "stores the station when touch in" do
    subject.top_up(Oystercard::LIMIT)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it "deletes entry station on touch out" do
    subject.top_up(Oystercard::LIMIT)
    subject.touch_in(station)
    subject.touch_out
    expect(subject.entry_station).to be nil
  end

end
