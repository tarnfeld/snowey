#!/usr/bin/env ruby

require 'socket'

hostname = '0.0.0.0'
port = 6543
command = "ID tweet"

socket = TCPSocket.open(hostname, port)
socket.print(command)
response = socket.read

puts response