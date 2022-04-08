require 'rspec'
require './greeting.rb'

RSpec.describe 'greeting() method' do
  it 'greeting VERY underage' do
    expect(greeting('name', 'surname', -100)).to eq("Привет name surname. Тебе меньше 18 лет, но начать учиться программировать никогда не рано.")
  end
  it 'greeting underage' do
    expect(greeting('name','surname',10)).to eq("Привет name surname. Тебе меньше 18 лет, но начать учиться программировать никогда не рано.")
  end
  it 'greeting 18 y.o.' do
    expect(greeting('name', 'surname', 18)).to eq("Привет name surname. Самое время заняться делом.")
  end
  it 'greeting adult' do
    expect(greeting('name', 'surname', 20)).to eq("Привет name surname. Самое время заняться делом.")
  end
end
