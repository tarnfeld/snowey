
module Snowey

	# This is the EventMachine event handler
	module Handler

		def post_init
			Logger::message "Client connected"
		end

		def receive_data data
			parser = Parser::CommandParser.new(data)
			command = parser.parse

			close_connection

			# begin
			# 	response = parser.parse
			# rescue ParserError => e
			# 	response = "ERR #{e.message}"
			# end

			# send_data response
			# close_connection_after_writing
		end

		def unbind
			Logger::message "Client disconnected"
		end
	end
end