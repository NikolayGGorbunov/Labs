#Простейшая реализация
#Идеи: Инит для аккаунта создает файл с балансом. Все методы
require 'stringio'
class Account
  attr_accessor :balance

  def initialize(id)
    @id = id
    filename = "#{@id}_balance.txt"
    @balance = File.exist?(filename) ? File.read(filename).to_f : 100.0
    update
  end

  def update
    File.write("#{@id}_balance.txt", balance)
  end
end

class CashMachine
  def initialize(connected)
    @connected = connected

    loop do
      puts "Please choose action\nB: Show balance | D: Deposit | W: Withdraw | Q: Quit"
      case $stdin.gets.chomp
      when 'Q', 'q'
        puts "Good bye!"
        break
      when 'B', 'b'
        show_balance
      when 'D', 'd'
        deposit
      when 'W', 'w'
        withdraw
      else puts "Invalid action. Try again"
      end
    end
  end

  def show_balance
    puts "Your balance is: #{@connected.balance}"
    #@connected.balance
  end

  def deposit
    puts 'How much do you want to deposit?'
    value = $stdin.gets.chomp.to_f
    if value > 0.0
      @connected.balance += value
      @connected.update
      puts "Your new balance is: #{@connected.balance}"
    else
      puts "You can't deposit negative or zero value. Try again."
    end
  end

  def withdraw
    puts 'How much do you want to withdraw?'
    value = $stdin.gets.chomp.to_f
    if value <= 0.0
      puts "You can't withraw negative or zero value. Try again"
    elsif value > @connected.balance
      puts "You can't withdraw more than your balance. Try again"
    else
      @connected.balance -= value
      @connected.update
      puts "Your new balance is: #{@connected.balance}"
    end
  end
end

#testaccount = Account.new(0)
#cash = CashMachine.new(testaccount)

#-------------------TESTS-------------------
require 'rspec'

RSpec.describe 'CashMachine class' do
  before:all do
    @testaccount = Account.new('test')
    @testaccount1 = Account.new('test1')
  end

  after:all do
    File.delete('test_balance.txt')
    File.delete('test1_balance.txt')
  end

  it 'show_balance() method print balance into terminal' do
    allow($stdin).to receive(:gets).and_return('q')
    expect{CashMachine.new(@testaccount).show_balance()}.to output(/^*Your balance is: 100.0/).to_stdout
  end

  it 'deposit() method increase the balance by the received number' do
    allow($stdin).to receive(:gets).and_return('q', '10')
    expect{CashMachine.new(@testaccount).deposit()}.to output(/^*Your new balance is: 110.0/).to_stdout

    allow($stdin).to receive(:gets).and_return('q', '0')
    expect{CashMachine.new(@testaccount).deposit()}.to output(/^*You can't deposit negative or zero value. Try again./).to_stdout
  end

  it 'withdraw() method decrease the balance by the received number' do
    allow($stdin).to receive(:gets).and_return('q', '10')
    expect{CashMachine.new(@testaccount1).withdraw()}.to output(/^*Your new balance is: 90.0/).to_stdout

    allow($stdin).to receive(:gets).and_return('q', '999')
    expect{CashMachine.new(@testaccount1).withdraw()}.to output(/^*You can't withdraw more than your balance. Try again/).to_stdout

    allow($stdin).to receive(:gets).and_return('q', '0')
    expect{CashMachine.new(@testaccount1).withdraw()}.to output(/^*You can't withraw negative or zero value. Try again/).to_stdout
  end
end
