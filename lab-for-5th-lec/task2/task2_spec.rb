require 'rspec'
require "./task2.rb"

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
