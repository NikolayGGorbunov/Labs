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

def deposit(balance)
  puts 'How much do you want to deposit?'
  value = $stdin.gets.chomp.to_f
  if value > 0.0
    balance = balance + value
  else
    puts "You can't deposit negative or zero value. Try again."
  end
  balance
end

def withdraw(balance)
  puts 'How much do you want to withdraw?'
  value = $stdin.gets.chomp.to_f
  if value <= 0.0
    puts "You can't withraw negative or zero value. Try again"
  elsif value > balance
    puts "You can't withdraw more than your balance. Try again"
  else
    balance = balance - value
  end
  balance
end

def quit(filename, balance)
  File.write(filename, balance)
end

def main_script()
  balance = init('balance.txt')
  loop do
    puts "Please choose action\nB: Show balance | D: Deposit | W: Withdraw | Q: Quit"
    case $stdin.gets.chomp
    when 'Q', 'q'
      quit('balance.txt', balance)
      break
    when 'B', 'b'
      puts balance
    when 'D', 'd'
      balance = deposit(balance)
    when 'W', 'w'
      balance = withdraw(balance)
    else
      puts 'Error: invalid value. Try again.'
    end
  end
end
