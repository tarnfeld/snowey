
module Snowey

  # Class for managing the snowey service
  class Service

    class Error < Error; end
    class ListenError < Error; end

    def initialize args

      @address = args[:address] || OPT_ADDRESS
      @port = args[:port] || OPT_PORT

      RangeStore.auth = args[:auth] || OPT_AUTH
      RangeStore.size = args[:size] || OPT_SIZE

      Logger.verbose = args[:verbose]  || OPT_VERBOSE
      Logger.debug = args[:debug] || OPT_DEBUG

      Logger.message "Welcome to Snowey. Version #{VERSION}"
      Logger.message "Initialized snowey with args #{args}", Logger::DEBUG
      listen
    end

    def listen
      
      Logger.message "Attempting to listen on #{@address}:#{@port}"

      EventMachine::run do

        Signal.trap("INT") do
          EventMachine.stop
          Logger.message "Caught signal INT", Logger::DEBUG
          Logger.message "Shutting down server, no longer accepting connections"
        end
        Signal.trap("TERM") do
          EventMachine.stop
          Logger.message "Caught signal TERM", Logger::DEBUG
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

      Logger.message "Received data '#{data.chomp}'", Logger::DEBUG

      begin
        parser = Parser::CommandParser.new(data)
        output = parser.parse
        send_data "#{output}\n"
      rescue Parser::Error => e
        send_data "ERR #{e.message}\n"
      end
    end

    def unbind
      Logger.message "Client disconnected"
    end
  end
end