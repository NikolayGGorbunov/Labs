#Я не смог придумать как проверить сценарий выводящий 'Something went wrong'((
require "./http_srv.rb"
require "rspec"

RSpec.describe '/balance' do
  before do
    @test_machine = CashMachine.new
  end
  it "show your balance" do
    expect(@test_machine.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/balance', 'OPT' => nil})).to include(200, [/^*is: 100.0/])
  end
end

RSpec.describe '/deposit' do
  before:all do
    @test_machine = CashMachine.new
  end
  before:each do
    @test_machine.balance = 100.0
  end
  it "increace your balance" do
    expect(@test_machine.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/deposit', 'OPT' => '?value=10'})).to include(200, [/^*is: 110.0/])
  end
  it "prevents nil option" do
    expect(@test_machine.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/deposit', 'OPT' => nil})).to include(400, [/^*option is nil/])
  end
  it "prevents zero value" do
    expect(@test_machine.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/deposit', 'OPT' => '?value=0'})).to include(400, [/^*wrong value/])
  end
  it "prevents negative value" do
    expect(@test_machine.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/deposit', 'OPT' => '?value=-10'})).to include(400, [/^*negative/])
  end
end

RSpec.describe '/withdraw' do
  before:all do
    @test_machine = CashMachine.new
  end
  before:each do
    @test_machine.balance = 100.0
  end
  it "decreace your balance" do
    expect(@test_machine.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/withdraw', 'OPT' => '?value=10'})).to include(200, [/^*is: 90.0/])
  end
  it "prevents nil option" do
    expect(@test_machine.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/withdraw', 'OPT' => nil})).to include(400, [/^*option is nil/])
  end
  it "prevents zero value" do
    expect(@test_machine.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/withdraw', 'OPT' => '?value=0'})).to include(400, [/^*wrong value/])
  end
  it "prevents negative value" do
    expect(@test_machine.call({'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/withdraw', 'OPT' => '?value=-10'})).to include(400, [/^*negative/])
  end
end
