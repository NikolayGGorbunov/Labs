require 'rspec'
require "./CashMachine.rb"

RSpec.describe 'CashMachine class' do
  before:all do
    @testaccount = Account.new('test')
    @testmachine = CashMachine.new(@testaccount)
  end

  before:each do
    @testaccount.balance = 100.0
    File.write('test_balance.txt', 100.0)
  end

  after:all do
    File.delete('test_balance.txt')
  end

  it 'show_balance() method print balance into terminal' do
    expect{@testmachine.show_balance()}.to output(/^*Your balance is: 100.0/).to_stdout
  end

  it 'deposit() method increase the balance by the received number' do
    allow($stdin).to receive(:gets).and_return('10')
    expect{@testmachine.deposit()}.to output(/^*Your new balance is: 110.0/).to_stdout

    allow($stdin).to receive(:gets).and_return('0')
    expect{@testmachine.deposit()}.to output(/^*You can't deposit negative or zero value. Try again./).to_stdout
  end

  it 'withdraw() method decrease the balance by the received number' do
    allow($stdin).to receive(:gets).and_return('10')
    expect{@testmachine.withdraw()}.to output(/^*Your new balance is: 90.0/).to_stdout

    allow($stdin).to receive(:gets).and_return('999')
    expect{@testmachine.withdraw()}.to output(/^*You can't withdraw more than your balance. Try again/).to_stdout

    allow($stdin).to receive(:gets).and_return('0')
    expect{@testmachine.withdraw()}.to output(/^*You can't withraw negative or zero value. Try again/).to_stdout
  end
end
