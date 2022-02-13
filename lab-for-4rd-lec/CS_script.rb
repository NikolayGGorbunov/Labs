def cs_script(word)
  word.end_with?('CS') ? 2**word.length : word.reverse
end

print "Введите слово.\n"
puts cs_script(gets.chomp!)
