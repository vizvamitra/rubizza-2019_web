# UDP

```bash
# start listening UDP port #4567
nc -u -l 4567

# show someone's listening
netstat --udp -n -l | grep 4567
```

```ruby
require 'socket'

socket = UDPSocket.new
socket.connect('127.0.0.1', 4567)
socket.sendmsg("hello udp!\n")
```

# TCP

```bash
# start listening TCP port #4567 (verbose mode)
nc -v -l 4567

# show someone's listening
netstat --tcp -n -l | grep 3000
```

```ruby
require 'socket'

socket = TCPSocket.new('127.0.0.1', 4567)
socket.sendmsg("hello tcp!\n")
```

# HTTP

```bash
# open tcp connection
nc example.com 80

# show opened connection
netstat --tcp -an | grep 80
```

HTTP request examples:

```
ABRVALG!

```

```
GET / HTTP/1.1
Host: example.com
Connection: close

```

```
OPTIONS / HTTP/1.1

```

```
POST / HTTP/1.1
Host: example.com
Content-Length: 5

a=123

```

