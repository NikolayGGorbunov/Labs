require 'rspec'
require './pokemon.rb'

RSpec.describe 'add_pokemon() method' do
  it 'wait name and color of pokemon from user and add this pokemon into array' do
    allow($stdin).to receive(:gets).and_return("TestName\n", "TestColor\n")
    expect(add_pokemon([])).to eq([{name: 'TestName',color: 'TestColor'}])
  end
end

RSpec.describe 'more_pokemons() method' do
  it 'wait number of pokemons and add_pokemon() n-times' do
    allow($stdin).to receive(:gets).and_return("2", "name1", 'color1', 'name2', 'color2')
    expect(more_pokemons([])).to eq([{name: 'name1', color: 'color1'},{name: 'name2', color: 'color2'}])
  end
end
