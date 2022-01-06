require "oystercard"

describe Oystercard do

  let(:station) { double :station }
  let(:another_station) { double :another_station }

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
    it "will not touch in if card has below minimum balance" do
      expect{ subject.touch_in(station) }.to raise_error "Insufficient funds"
    end
  end
  
  describe "touch out method" do

    it "reduces the balance by the minimum fare" do
      expect { subject.touch_out(another_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM)
    end
  end
end
