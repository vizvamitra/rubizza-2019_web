require_relative './http_server'

app = proc do |env|
  [200, { 'Content-type': 'text/plain' }, ['Hello world!']]
end

server = HTTPServer.new(app, port: 3000, debug: true)
server.run
