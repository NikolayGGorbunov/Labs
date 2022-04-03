require 'stringio'

def read_students(filename_students)
  file = File.open(filename_students)
  students_list = file.readlines.map(&:chomp)
  file.close
  students_list
end

def write_students(students, age, filename_result)
  loop do
    if age.length != 2
       puts 'Age must be between 10 and 99'
       age = $stdin.gets.chomp
    else
      break
    end
  end
  file = File.open(filename_result, 'a')
  written_students = Array.new
  students.map do |student|
    if student.include?(age)
      file.write(student + "\n")
      written_students << student
    end
  end
  file.close
  students - written_students
end

def sort_students(filename_students, filename_result)
  File.delete(filename_result) if File.exist?(filename_result)
  students = read_students(filename_students)
  start_len = students.length
  final_len = 0
  puts students
  puts 'Enter the age of the student'
  while !students.empty?
    students = write_students(students, $stdin.gets.chomp, filename_result)
    final_len += 1
    puts '++++++++++++++++++++++++++++'
    puts students
    puts 'Enter the age of the student'
  end
  [students.empty?, final_len == start_len]
end

#sort_students('students.txt', 'result.txt')

#-------------------TESTS-------------------
require 'rspec'

RSpec.describe 'read_students() method' do
  before:all do
    File.delete('teststudents.txt') if File.exist?('teststudents.txt')
    File.write('teststudents.txt', "Иван Иванов 20\nПетр Петров 23\n")
  end
  after:all do
    File.delete('teststudents.txt')
  end

  it 'puts students from file and return array of students' do
    expect(read_students('teststudents.txt')).to eq(['Иван Иванов 20', 'Петр Петров 23'])
  end
end

RSpec.describe 'write_students() method' do
  before:all do
    @students = ['Иван Иванов 20', 'Петр Петров 23']
  end
  after:all do
    File.delete('testresult.txt')
  end

  it "takes the student's age and moves all students with that age to the result file. Returns the remaining students." do
    expect(write_students(@students, '23', 'testresult.txt')).to eq(['Иван Иванов 20'])
  end
end

RSpec.describe 'sort_students() method' do
  before:all do
    File.delete('teststudents.txt') if File.exist?('teststudents.txt')
    File.write('teststudents.txt', "Иван Иванов 20\nПетр Петров 23\n")
  end
  after:all do
    File.delete('teststudents.txt')
    File.delete('testresult.txt')
  end

  it "rewrites students from a given file into a new file in a given order with respect to age." do
    allow($stdin).to receive(:gets).and_return('23', '20')
    expect(sort_students('teststudents.txt', 'testresult.txt')).to eq([true, true])
  end
end
