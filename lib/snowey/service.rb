
module Snowey

  # The main snowey service manager class
  class Service

    def initialize args

      # Default listen address:port
      @address  = ADDRESS
      @port      = PORT

      # Custom listen address:port
      if args.has_key?(:address)
        @address = args[:address]
      end

      if args.has_key?(:port)
        @port = args[:port]
      end

      Logger::message "Welcome to Snowey. Version #{VERSION}"

      # Start listening
      listen
    end

    def listen
      
      Logger::message "Attempting to listen on #{@address}:#{@port}"

      EventMachine::run do

        Signal.trap("INT") do
          EventMachine.stop
          Logger::message "Shutting down server, no longer accepting connections"
        end
        Signal.trap("TERM") do
          EventMachine.stop
          Logger::message "Shutting down server, no longer accepting connections"
        end

        EventMachine::start_server @address, @port, Handler
        Logger::message "Snowey is ready to accept connections on #{@address}:#{@port}"
      end
    end
  end
end