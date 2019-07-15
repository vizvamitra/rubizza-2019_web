class App
  def call(env)
    case env['PATH_INFO']

    when '/'        then root_action(env)
    when '/posts'   then posts_index_action(env)
    when '/authors' then authors_index_action(env)
    when '/about'   then about_action(env)
    # ...
    else               not_found_action(env)

    end
  end

  private

  def root_action(env)
    ['200', { 'Content-Type' => 'text/plain' }, [root_template]]
  end

  def root_template
    <<~HTML
      <!DOCTYPE html>
      <html>
        <head></head>
        <body>
          <h1>My awesome website</h1>
        </body>
      </html>
    HTML
  end

  # ...
end

run App.new
