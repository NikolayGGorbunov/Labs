require 'rspec'
require './task1.rb'

RSpec.describe 'CRUD method' do
  before do
    File.delete('testme.txt') if File.exist?('testme.txt')
    File.write('testme.txt', "first_line\nsecond_line")
  end

  after do
    File.delete('testme.txt') if File.exist?('testme.txt')
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
