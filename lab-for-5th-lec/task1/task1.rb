#(id) - номер строки
#index - выводит все строки в файле
#find(id) - находит конкретную строку в файле и выводит ее
#where(pattern) - находит все строки где есть указанный паттерн
#update(id, text) - обновляет конкретную строку файла
#delete(id) - удаляет строку

def index(file_name)
  file_data = File.read(file_name).split("\n")
  file_data
end

def find(file_name, id)
  file = File.open(file_name)
  file_data = file.readlines.map(&:chomp)
  file.close
  file_data[id]
end

def where(file_name, pattern)
  file_data = []
  file = File.open(file_name)
  file.readlines.map.with_index{|line, i| line.chomp.include?(pattern) ? file_data.push(i) : next}
  file.close
  file_data
end

def update(file_name, id, new_line)
  buf_file = File.open('buf.txt', 'w')
  result = "Line not found"
  File.foreach(file_name).with_index do |line, index|
    buf_file.puts(index == id ? new_line : line)
    if index == id
      buf_file.puts(new_line)
      result = [id, line, new_line]
    else
      buf_file.puts(line)
    end
  end
  buf_file.close
  File.write(file_name, File.read('buf.txt'))
  File.delete('buf.txt') if File.exist?('buf.txt')
  result
end

def delete(file_name, id)
  buf_file = File.open('buf.txt', 'w')
  result = 'Line not found'
  File.foreach(file_name).with_index do |line, index|
    if index == id
      result = [id, line]
    else
      buf_file.puts(line)
    end
  end
  buf_file.close
  File.write(file_name, File.read('buf.txt'))
  File.delete('buf.txt') if File.exist?('buf.txt')
  result
end
