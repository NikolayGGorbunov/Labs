#Простейшая реализация
#Идеи: Инит для аккаунта создает файл с балансом. Все методы
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
      case gets.chomp
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
  end

  def deposit
    puts 'How much do you want to deposit?'
    value = gets.chomp.to_f
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
    value = gets.chomp.to_f
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

testaccount = Account.new(0)
cash = CashMachine.new(testaccount)
