
module Snowey
  
  # This is the input parser
  module Parser

    COMMANDS = {}

    def self.add_command command, arguments = []
      COMMANDS[command] = arguments
    end

    class CommandParser

      def initialize input
        @input = input
      end

      def parse
        parsed = @input.split(" ")
        @command = parsed.shift.upcase
        @arguments = parsed

        # Validate the command
        if !@command || !is_command?(@command)
          Logger::error "Invalid command '#{@input}'"
          # Throw an error here?
          return
        end

        # Validate the number of arguments
        if @arguments.length != get_arguments(@command).length
          Logger::error "Invalid number of arguments for '#{@command}'"
          # Throw another error here?
          return
        end

        # Execute the command
        execute
      end

      def execute
        Logger::message "Executing command '#{@command}' with arguments '#{@arguments}'"
      end

      def is_command? command
        COMMANDS.has_key? command
      end

      def arguments command
        if !is_command?(command)
          return
        end
        COMMANDS[command]
      end
    end
  end
end