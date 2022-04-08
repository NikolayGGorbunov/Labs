require 'rspec'
require './CS_script.rb'

RSpec.describe 'cs_script method' do
  it "return 2^(word length) (== 8) if word end with 'CS'" do
    expect(cs_script('8CS')).to eq(8)
  end
  it "return reversed word (== esrever) if word not end with 'CS'" do
    expect(cs_script('reverse')).to eq('esrever')
  end
end
