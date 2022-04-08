def cs_script(word.chomp!)
  word.end_with?('CS') ? 2**word.length : word.reverse
end
