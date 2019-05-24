require "socket"

host = ENV["BIND_ADDRESS"] || "localhost"
port = ENV["PORT"] ? ENV["PORT"].to_i : 2345

server = TCPServer.new(host, port)
STDERR.puts "Starting server at #{host}:#{port}"

loop do
  session = server.accept

  while (request = session.gets) && (request.chomp.length > 0)
    STDERR.puts request.chomp
  end
  STDERR.puts "------------------"

  response = "Hola desde Ruby\n"
  session.print <<~RESPONSE
  HTTP/1.1 200 OK
  Content-Type: text/plain
  Content-Length: #{response.bytesize}
  Connection: close
  RESPONSE

  session.print "\r\n"
  session.print response

  session.close
end
