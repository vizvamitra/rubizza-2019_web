require 'socket'

class HTTPServer
  def initialize(app, port: 3000, debug: false)
    @server = TCPServer.new(port)
    @app = app
    @debug = debug
  end

  def run
    loop do
      conn = server.accept

      puts("\n#### REQUEST RECEIVED! ####\n") if debug

      request = get_request(conn)
      puts(request) if debug

      env = parse_request(request)
      puts(env, "\n") if debug

      status, headers, body = app.call(env)

      conn.puts build_response(status, headers, body)
      conn.close
    end
  end

  private

  attr_reader :server, :app, :debug

  def get_request(conn)
    request = []

    while line = conn.gets
      request << line
      break if line =~ /^\s*\n\s*$/m
    end

    request
  end

  def parse_request(request)
    method, path, _ = request[0].split(' ')

    {
      "REQUEST_METHOD" => method,
      "PATH_INFO" => path,
    }
  end

  def build_response(status, headers, body)
    status_message = status == 200 ? 'OK' : 'Not OK'
    headers_string = headers.map { |name, value| "#{name}: #{value}" }.join("\n")

    <<~HTTP
      HTTP/1.1 #{status} #{status_message}
      #{headers_string}

      #{body.join}
    HTTP
  end
end
