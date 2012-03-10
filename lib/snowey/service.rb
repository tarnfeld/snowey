
module Snowey

  # Class for managing the snowey service
  class Service

    class Error < Error; end
    class ListenError < Error; end

    def initialize args

      @address = args[:address] || ADDRESS
      @port = args[:port] || PORT

      Logger.verbose(args[:verbose] || VERBOSE)
      Logger.debug(args[:debug] || DEBUG)

      Logger.message "Welcome to Snowey. Version #{VERSION}"
      listen
    end

    def listen
      
      Logger.message "Attempting to listen on #{@address}:#{@port}"

      EventMachine::run do

        Signal.trap("INT") do
          EventMachine.stop
          Logger.message "Shutting down server, no longer accepting connections"
        end
        Signal.trap("TERM") do
          EventMachine.stop
          Logger.message "Shutting down server, no longer accepting connections"
        end

        EventMachine::add_periodic_timer(5) {
          connected = EventMachine::connection_count - 1
          Logger.message "#{connected} clients connected"
        }

        EventMachine::start_server @address, @port, ConnectionHandler
        Logger.message "Snowey is ready to accept connections on #{@address}:#{@port}"
      end
    end
  end

  # EventMachine Connection Handler
  module ConnectionHandler

    def post_init
      Logger.message "Client connected"
    end

    def receive_data data

      begin
        parser = Parser::CommandParser.new(data)
        output = parser.parse
        send_data "Some output #{output}\n"
      rescue Parser::Error => e
        send_data "ERR #{e.message}\n"
      end
    end

    def unbind
      Logger.message "Client disconnected"
    end
  end
end