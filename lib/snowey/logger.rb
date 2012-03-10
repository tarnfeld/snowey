
module Snowey

  module Logger

    def message message
      puts "#{prefix} - #{message}"
    end

    def error error
      puts color("#{prefix} - #{error}", "#FF0000")
    end

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
