
module Snowey
  
  # This is the input parser
  module Parser

    class Error < Error; end
    class UnknownCommand < Error; end
    class ExecutionError < Error; end
    class InvalidInput < Error; end

    module CommandManager

      COMMANDS = {}

      def add_command command, arguments = []
        COMMANDS[command] = arguments
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

      module_function :add_command
      module_function :is_command?
      module_function :arguments
    end

    class CommandParser

      include CommandManager;

      def initialize input
        @input = input
      end

      def parse
        parsed = @input.split(" ")

        if !parsed || parsed.length <= 0
          Logger.error "Invalid input data"
          raise InvalidInput.new "Invalid input data"
        end

        @command = parsed.shift.upcase
        @arguments = parsed

        # Validate the command
        if !@command || !is_command?(@command)
          Logger.error "Invalid command '#{@input}'"
          raise UnknownCommand.new "#{@command} is not a valid command"
        end

        # Validate the number of arguments
        if @arguments.length != arguments(@command).length
          Logger.error "Invalid number of arguments for '#{@command}'"
          raise ExecutionError.new "Invalid number of arguments. #{@arguments.length} passed, #{arguments(@command).length} expected"
        end

        # Convert the arguments into a usable state
        args = CommandManager.arguments @command
        @arguments = Hash[args.zip(@arguments)]

        # Execute the command
        execute
      end

      def execute
        Logger.message "Executing command '#{@command}' with arguments '#{@arguments}'", Logger::DEBUG
        Commands.const_get(@command).execute(@arguments)
      end
    end
  end
end