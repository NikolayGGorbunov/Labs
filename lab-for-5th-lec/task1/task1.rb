#(id) - номер строки
#index - выводит все строки в файле
#find(id) - находит конкретную строку в файле и выводит ее
#where(pattern) - находит все строки где есть указанный паттерн
#update(id, text) - обновляет конкретную строку файла
#delete(id) - удаляет строку

def index(file_name)
  file_data = File.read(file_name).split('\n')
  puts file_data
end

def find(file_name, id)
  file = File.open(file_name)
  file_data = file.readlines.map(&:chomp)
  file.close
  puts file_data[id]
end

def where(file_name, pattern)
  file = File.open(file_name)
  file_data = file.readlines.map(&:chomp)
  file.close
  result = Array.new
  file_data.map.with_index{|line, i| line.include?(pattern) ? result.push(i) : next}
  result
end

#Я не был уверен что where() работает хорошо с точки зрения работы с памятью и попытался написать new_where() который бы работал лучше
#Пока-что понятия не имею как проверить кто из них ест меньше оперативной памяти

def new_where(file_name, pattern)
  file_data = []
  file = File.open(file_name)
  file.readlines.map.with_index{|line, i| line.chomp.include?(pattern) ? file_data.push(i) : next}
  file.close
  file_data
end

#А потом я увидел что в лекции был пример с тем как написать where() в 3 строки...

def update(file_name, id, new_line)
  buf_file = File.open('buf.txt', 'w')
  File.foreach(file_name).with_index do |line, index|
    buf_file.puts(index == id ? new_line : line)
  end
  buf_file.close
  File.write(file_name, File.read('buf.txt'))
  File.delete('buf.txt') if File.exist?('buf.txt')
end

def delete(file_name, id)
  buf_file = File.open('buf.txt', 'w')
  File.foreach(file_name).with_index do |line, index|
    buf_file.puts(index == id ? next : line)
  end
  buf_file.close
  File.write(file_name, File.read('buf.txt'))
  File.delete('buf.txt') if File.exist?('buf.txt')
end
