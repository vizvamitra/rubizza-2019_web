class App
  def call(env)
    case env['PATH_INFO']

    when '/'      then root_action(env)
    when '/hello' then hello_action(env)
    else               not_found_action(env)

    end
  end

  private

  def params(env)
    env['QUERY_STRING'].split('&').map { |kv_pair| kv_pair.split('=') }.to_h
  end

  # actions

  def root_action(env)
    ['200', { 'Content-Type' => 'text/plain' }, [root_template]]
  end

  def hello_action(env)
    username = params(env).fetch('username', 'Anon')
    ['200', { 'Content-Type' => 'text/html' }, [hello_template(username)]]
  end

  def not_found_action(env)
    ['404', { 'Content-Type' => 'text/html' }, [not_found_template]]
  end

  # templates

  def root_template
    'hello'
  end

  def hello_template(username)
    <<~HTML
      <h1>Hello, #{username}</h1>
      <p>How are you?</p>
    HTML
  end

  def not_found_template
    <<~HTML
      <h1>404 Not Found</h1>
      <p>Sorry for that ^_^</p>
    HTML
  end
end

run App.new
