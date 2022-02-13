def add_pokemon(arr)
  print "Как зовут покемона?\n"
  pokemon_name = gets.chomp
  print "Какого он цвета?\n"
  pokemon_color = gets.chomp
  arr << Hash['name', pokemon_name, 'color', pokemon_color]
end

#Я не был уверен стоит ли оставлять вывод по типу puts pokemons
#В таком выводе разделителем выступал "=>" а также имена ключей заключались в кавычки,
#Поэтому я написал метод show которыйй выводит массив хэшэй в формате который был дан в задании
pokemons = Array.new

print "Сколько покемонов добавить?\n"
n = gets.chomp.to_i
for i in 0..n-1 do
  add_pokemon(pokemons)
end
puts pokemons
