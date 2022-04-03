require 'stringio'
DEFAULT_BALANCE = 100.0

def init(filename)
  if File.exist?(filename)
    File.read(filename).to_f
  else
    File.write(filename, DEFAULT_BALANCE)
    DEFAULT_BALANCE
  end
end

def deposit(balance, value)
  new_balance = (balance + value)
end

def withdraw()
  new_balance = (balance - value)
end

def show_balance(balance)
  puts balance
end

def quit(filename, balance)
  File.write(filename, balance)
end

balance = init('balance.txt')
loop do
  puts "Please choose action\nB: Show balance | D: Deposit | W: Withdraw | Q: Quit"
  case $stdin.gets.chomp
  when 'Q', 'q'
    quit('balance.txt', balance)
    break
  when 'B', 'b'
    show_balance(balance)
  when 'D', 'd'
    puts 'How much do you want to deposit?'
    value = gets.chomp.to_f
    if value > 0.0
      balance = deposit(balance, value)
    else
      puts "You can't deposit negative or zero value. Try again."
    end
  when 'W', 'w'
    puts 'How much do you want to withdraw?'
    value = gets.chomp.to_f
    if value <= 0.0
      puts "You can't withraw negative or zero value. Try again"
    elsif value > balance
      puts "You can't withdraw more than your balance. Try again"
    else
      balance = withdraw(balance, value)
    end
  else
    puts 'Error: invalid value. Try again.'
  end
end

#-------------------TESTS-------------------
#Тесты здесь только на init() потому что остальные методы это стандартные операции
#Тесты на варианта банкомата с классами будут более полные потому что эта реализация в целом неудобная
require 'rspec'

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
    #allow($stdin).to receive(:gets).and_return('q')
    expect(init('default_balance.txt')).to eq(100.0)
  end
  it 'read balance from file and return it' do
    expect(init('testbalance.txt')).to eq(1999.0)
  end
end
