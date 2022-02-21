DEFAULT_BALANCE = 100.0

def init()
  File.exist?('balance.txt') ? File.read('balance.txt') : DEFAULT_BALANCE
end

def deposit(balance, value)
  new_balance = (balance.to_f + value.to_f).to_s
end

def withdraw()
  new_balance = (balance.to_f - value.to_f).to_s
end

def show_balance(balance)
  puts balance
end

def quit(balance)
  File.write('balance.txt', balance)
end

balance = init()
loop do
  puts "Please choose action\nB: Show balance | D: Deposit | W: Withdraw | Q: Quit"
  case gets.chomp
  when 'Q', 'q'
    quit(balance)
    break
  when 'B', 'b'
    show_balance(balance)
  when 'D', 'd'
    puts 'How much do you want to deposit?'
    value = gets.chomp
    if value.to_f > 0.0
      balance = deposit(balance, value)
    else
      puts "You can't deposit negative or zero value. Try again."
    end
  when 'W', 'w'
    puts 'How much do you want to withdraw?'
    value = gets.chomp
    if value.to_f <= 0.0
      puts "You can't withraw negative or zero value. Try again"
    elsif value.to_f > balance
      puts "You can't withdraw more than your balance. Try again"
    else
      balance = withdraw(balance, value)
  else
    puts 'Error: invalid value. Try again.'
  end
end
