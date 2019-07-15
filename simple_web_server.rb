require 'socket'

server = TCPServer.new(6543)

loop do
  conn = server.accept

  request = []
  while line = conn.gets
    request << line
    break if line == "\n"
  end
  puts request

  conn.puts <<~HTTP
    HTTP/1.1 200 OK
    content-type: text/plain; charset=utf-8

    Hello world!
  HTTP

  conn.close
end
