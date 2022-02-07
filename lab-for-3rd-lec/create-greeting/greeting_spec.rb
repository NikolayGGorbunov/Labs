require 'rspec'
require './greeting.rb'

RSpec.describe 'greeting method' do
  it 'return when age is under 18' do
    expect(greeting('name','surname',10)).to eq("Привет name surname. Тебе меньше 18 лет, но начать учиться программировать никогда не рано.")
  end
  it 'return when age is greather than 18' do
    expect(greeting('name', 'surname', 20)).to eq("Привет name surname. Самое время заняться делом.")
  end
end
