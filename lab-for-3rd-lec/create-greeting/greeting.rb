def greeting(name, surname, age)
  message = "Привет #{name} #{surname}. "
  if age >= 18
    message+"Самое время заняться делом."
  else
    message+"Тебе меньше 18 лет, но начать учиться программировать никогда не рано."
  end
end

print "Как тебя зовут? (ФИ)\n"
name, surname = gets.split(' ')
print "Сколько тебе лет?\n"
age = gets.chomp.to_i

puts greeting(name, surname, age)
