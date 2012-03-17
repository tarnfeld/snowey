
module Snowey

  module Logger

    # Flags
    DEBUG = 1
    ALERT = 2

    # Should the logger be verbose?
    @verbose = true
    @debug = false

    def verbose=(verbose)
      @verbose = verbose
    end

    def debug=(debug)
      @debug = debug
    end

    def message message, flag = 0
      if flag == ALERT
        puts "#{prefix} - #{color(message, '#429dbc')}"
      elsif flag == DEBUG
        puts "#{prefix} - #{color(message, '#FFFF00')}" if @debug
      else
        puts "#{prefix} - #{message}" if @verbose
      end
    end

    def error error
      puts color("#{prefix} - #{error}", "#FF0000") if @verbose
    end

    module_function :verbose=
    module_function :debug=

    module_function :message
    module_function :error

    private

    def prefix
      pid = color("[#{Process.pid}]", "#429dbc")
      time = Time.now.strftime("%d %b %H:%M:%S")

      "#{pid} #{time}"
    end

    def color string, color
      if string.respond_to?(:color)
        return string.color(color)
      end
      string
    end

    module_function :prefix
    module_function :color
  end
end
