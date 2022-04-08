require 'stringio'

def add_pokemon(pokemons_arr)
  puts "Как зовут покемона?"
  pokemon_name = $stdin.gets.chomp
  puts "Какого он цвета?"
  pokemon_color = $stdin.gets.chomp
  pokemons_arr << {name: pokemon_name, color: pokemon_color}
end

def more_pokemons(pokemons_arr)
  print "Сколько покемонов добавить?\n"
  n = $stdin.gets.chomp.to_i
  for i in 0..n-1 do
    add_pokemon(pokemons_arr)
  end
  pokemons_arr
end
