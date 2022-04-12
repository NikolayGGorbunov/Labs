require 'socket'
require 'rack'

class CashMachine
  attr_accessor :balance
  def initialize
    @balance = 100.0
  end

  def call(env)
      content_type = {'Content_type' => 'text/plain'}
      error_msg = 'Error: '
      case env["PATH_INFO"]
      when '/balance'
        [200, content_type, ["Your balance is: #{@balance}"]]
      when '/deposit'
        value = env['OPT']
        if value.nil?
          return [400, content_type, [error_msg << "option is nil"]]
        else
          value = value.split('=')[1].to_f
        end
        if value > 0.0
          @balance += value
          [200, content_type, ["Your balance incresed! Current balance is: #{@balance}"]]
        elsif value < 0.0
          [400, content_type, [error_msg << "you can't deposit negative value. Try /withdraw"]]
        elsif value == 0.0
          [400, content_type, [error_msg << "wrong value. Please try /deposit?value="]]
        else
          [400, content_type, [error_msg << "something went wrong\n", "#{env}"]]
        end
      when '/withdraw'
        value = env['OPT']
        if value.nil?
          return [400, content_type, [error_msg << "option is nil."]]
        else
          value = value.split('=')[1].to_f
        end
        if value > 0.0 && value < @balance
          @balance -= value
          [200, content_type, ["Your balance decresed! Current balance is: #{@balance}"]]
        elsif  value > 0.0 && value > @balance
          [400, content_type, [error_msg << "you can't withdraw moree then your balance"]]
        elsif value < 0.0
          [400, content_type, [error_msg << "you can't withdraw negative value. Try /deposit"]]
        elsif value == 0.0
          [400, content_type, [error_msg << "wrong value. Please try /withdraw?value="]]
        else
          [400, content_type, [error_msg << "something wen't wrong\n", "#{env}"]]
        end
      else
        [404, content_type, [error_msg << "function not found"]]
      end
  end
end

def server_init
  server = TCPServer.new('localhost', 3000)
  http_machine = CashMachine.new

  while connection = server.accept
    request = connection.gets
    method, full_path = request.split(' ')
    path, option = full_path.split('?')

    status, headers, body = http_machine.call({
      'REQUEST_METHOD' => method,
      'PATH_INFO' => path,
      'OPT' => option
      })

    connection.print("HTTP/1.1 #{status}\r\n")
    headers.each do |key, value|
      connection.print("#{key}: #{value}\r\n")
    end
    connection.print "\r\n"
    body.each do |part|
      connection.print(part)
    end
    connection.close
  end
end

#server_init
