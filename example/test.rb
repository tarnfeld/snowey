#!/usr/bin/env ruby

require 'socket'

opts = {
  :address => "0.0.0.0",
  :port => 2478
}

connection = TCPSocket.open opts[:address], opts[:port]

start = Time.now
tag = "twtmore"

for i in 0..100000 do
	connection.print "ID #{tag}"
	x = connection.gets
	p x
end

fin = Time.now
diff = fin-start

p "Generated #{i} IDs for tag #{tag} in #{diff} seconds"

# Close the connection
connection.close
