require 'rspec'
require "./task3.rb"

RSpec.describe 'init() method' do
  before:all do
    File.delete('testbalance.txt') if File.exist?('testbalance.txt')
    File.write('testbalance.txt', 1999.0)
  end
  after:all do
    File.delete('testbalance.txt')
    File.delete('default_balance.txt')
  end

  it 'create new balance file with default value and return balance' do
    expect(init('default_balance.txt')).to eq(100.0)
  end
  it 'read balance from file and return it' do
    expect(init('testbalance.txt')).to eq(1999.0)
  end
end

RSpec.describe 'deposit() method' do
  it 'take curent balance and increace it by value' do
    allow($stdin).to receive(:gets).and_return('10')
    expect(deposit(0)).to eq(10.0)
  end
  it 'dont increace balance if value == 0' do
    allow($stdin).to receive(:gets).and_return('0')
    expect(deposit(0)).to eq(0)
  end
  it 'dont increace balance if value < 0' do
    allow($stdin).to receive(:gets).and_return('-10')
    expect(deposit(0)).to eq(0)
  end
end

RSpec.describe 'withdraw() method' do
  it 'take curent balance and decreace it by value' do
    allow($stdin).to receive(:gets).and_return('10')
    expect(withdraw(10.0)).to eq(0.0)
  end
  it 'dont decreace balance if value == 0' do
    allow($stdin).to receive(:gets).and_return('0')
    expect(withdraw(10.0)).to eq(10.0)
  end
  it 'dont increace balance if value < 0' do
    allow($stdin).to receive(:gets).and_return('-10')
    expect(withdraw(10.0)).to eq(10.0)
  end
  it 'dont decreace balance if value > balance' do
    allow($stdin).to receive(:gets).and_return('100')
    expect(withdraw(10.0)).to eq(10.0)
  end
end
