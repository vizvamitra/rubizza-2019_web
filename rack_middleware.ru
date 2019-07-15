class Cache
  def initialize(app)
    @app = app
    @cache = {}
  end

  def call(env)
    path = env['PATH_INFO']

    if @cache.key?(path)
      puts "Returning cached response for #{path}"
    else
      @cache[path] = @app.call(env)
    end

    @cache[path]
  end
end

inner_app = proc do |env|
  puts "Inner app called with #{env}"
  require 'pry'; binding.pry
  sleep 2 # simulate long-running process
  [200, { 'Content-type' => 'text/plain' }, ['Hello middleware!']]
end

wrapped_app = Cache.new(inner_app)

run wrapped_app
