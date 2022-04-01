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

#-------------------TESTS-------------------

require 'rspec'
RSpec.describe 'CRUD method' do
  before do
    File.delete('testme.txt') if File.exist?('testme.txt')
    File.write('testme.txt', "first_line\nsecond_line")
  end

  it 'index() return array of file lines' do
    expect(index('testme.txt')).to eq(["first_line", "second_line"])
  end
  it 'find() take id of line and return this line' do
    expect(find('testme.txt', 1)).to eq('second_line')
  end
  it "where() take pattern-string and return an array of strings containing a pattern-substring id's" do
    expect(where('testme.txt', 'line')).to eq([0, 1])
  end
  it 'update() take id of line and new_line, then update file and return array with id, old and new lines' do
    expect(update('testme.txt', 1, 'updated')).to eq([1, 'second_line', 'updated'])
  end
  it 'delete() take id of line and delete this line. Return id and deleted line' do
    expect(delete('testme.txt', 1)).to eq([1, 'second_line'])
  end
end
