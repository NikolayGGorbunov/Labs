require 'rspec'
require './foobar.rb'

RSpec.describe 'foobar method' do
  it "return 2'nd number" do
    expect(foobar(20, 10)).to eq(10)
  end
  it "return sum of numbers" do
    expect(foobar(10, 11)).to eq(21)
  end
end
