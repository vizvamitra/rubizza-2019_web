require 'socket'

class HTTPServer
  def initialize(app, port: 6543)
    @server = TCPServer.new(port)
    @app = app
  end

  def run
    loop do
      conn = @server.accept

      request = get_request(conn)
      env = parse_request(request)

      status, headers, body = @app.call(env)

      conn.puts build_response(status, headers, body)
      conn.close
    end
  end
end

app = proc { |env| [200, { 'Content-Type' => 'text/plain' }, ['Hello web!']] }
HTTPServer.new(app).run
