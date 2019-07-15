# Gemfile
# source 'https://rubygems.org'
#
# gem 'sinatra'
# gem 'redis'
# gem 'haml'

# app.rb
require 'sinatra'
require 'haml'
require 'redis'

set :redis, Redis.new(url: 'redis://127.0.0.1:6379/0')

get '/secret' do
  secret = settings.redis.get('secret') || 'secret is not set yet'
  haml :secret, locals: { secret: secret }
end

post '/secret' do
  new_secret = params.fetch('secret') { halt 422 }
  settings.redis.set('secret', new_secret)

  redirect to('/secret')
end

error(422) { 'Unprocessable Entity' }

__END__

@@ layout
%html
  = yield

@@ secret
Current secret:
%strong= secret

%form{method: 'POST', action: '/secret'}
  %input{name: 'secret', placeholder: 'Enter new secret'}
  %button{type: 'submit'} Save
