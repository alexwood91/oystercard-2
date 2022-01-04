require "oystercard"

describe Oystercard do

  it "is able to store the customers balance" do
    
    expect(subject.balance).to eq 0

  end

  it "responds to top_up method" do
    expect(subject).to respond_to(:top_up).with(1).argument

  end

  it "increases the balance by the top up value" do
    expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    # expect(subject.top_up(5)).to eq 5
  end

  it "maximum limit reached" do
    expect{ subject.top_up(100) }.to raise_error "Maximum limit of #{Oystercard::LIMIT} has been reached"
  end

end

