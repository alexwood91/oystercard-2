require "oystercard"

describe Oystercard do

  it "is able to store the customers balance" do
    
    expect(subject.balance).to eq 0
    
  end
end

