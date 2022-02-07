def foobar(a, b)
  a == 20 || b == 20 ? b : a + b
end

print 'Введите два числа разделенные пробелом. (a b)'
a, b = gets.split(' ').map!{|x|x.to_i}
puts foobar(a, b)
