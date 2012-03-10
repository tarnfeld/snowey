
module Snowey

	# This is the EventMachine event handler
	module Handler

		def post_init
			Logger::message "Client connected"
		end

		def receive_data data
			send_data "This is a response"
			close_connection_after_writing
		end

		def unbind
			Logger::message "Client disconnected"
		end
	end
end