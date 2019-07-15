app = proc do |env|
  ['200', { 'Content-Type' => 'text/html' }, ["<h1>Hello rack!</h1>"]]
end

run app
