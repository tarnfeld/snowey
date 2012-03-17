#!/usr/bin/env ruby

require 'socket'

opts = {
  :address => "0.0.0.0",
  :port => 2478
}

connection = TCPSocket.open opts[:address], opts[:port]

# Get ID
connection.print "ID twtmore"
puts connection.gets

# Get INFO
connection.print "INFO twtmore"
puts connection.gets

# Close the connection
connection.close
