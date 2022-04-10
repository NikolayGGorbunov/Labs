require 'socket'
require 'rack'

server = TCPServer.new('localhost', 3000)

class CashMachine
  @@balance = 100.0

  def call(env)
      case env["PATH_INFO"]
      when '/balance'
        [200, {'Content_Type' => 'text/plain'}, ["Your balance is: #{@@balance}"]]
      when '/deposit'
        value = env['OPT'].split('=')[1].to_i
        @@balance += value
        [200, {'Content_Type' => 'text/plain'}, ["Your balance incresed! Current balance is: #{@@balance}"]]
      when '/withdraw'
        value = env['OPT'].split('=')[1].to_i
        @@balance -= value
        [200, {'Content_Type' => 'text/plain'}, ["Your balance decresed! Current balance is: #{@@balance}"]]
      else
        [400, {'Content_Type' => 'text/plain'}, ["Something went wrong\n", "#{env}"]]
      end
  end
end

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
