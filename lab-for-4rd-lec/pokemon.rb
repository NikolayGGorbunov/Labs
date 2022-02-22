require 'stringio'

def add_pokemon(arr)
  puts "Как зовут покемона?"
  pokemon_name = $stdin.gets.chomp
  puts "Какого он цвета?"
  pokemon_color = $stdin.gets.chomp
  arr << Hash[{name: pokemon_name, color: pokemon_color}]
end

pokemons = Array.new

print "Сколько покемонов добавить?\n"
n = gets.chomp.to_i
for i in 0..n-1 do
  add_pokemon(pokemons)
end
puts pokemons

#-------------------TESTS-------------------
require 'rspec'

RSpec.describe 'add_pokemon method' do
  before do
    @arr = Array.new()
  end

  it 'wait name and color of pokemon from user and add this pokemon into array' do
    allow($stdin).to receive(:gets).and_return("TestName\n", "TestColor\n")
    expect(add_pokemon(@arr)).to eq([{name: 'TestName',color: 'TestColor'}])
  end
end
