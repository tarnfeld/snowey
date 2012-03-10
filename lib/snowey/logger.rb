
begin
  require "rainbow"
rescue LoadError => e
  # Lets not worry about this
end

module Snowey

  # Logger module
  module Logger

    def self.message message
      puts "#{self.prefix} - #{message}"
    end

    def self.error error
      puts self.color("#{self.prefix} - #{error}", "#FF0000")
    end

    def self.prefix
      pid = self.color("[#{Process.pid}]", "#429dbc")
      time = Time.now.strftime("%d %b %H:%M:%S")

      "#{pid} #{time}"
    end

    def self.color string, color
      if string.respond_to?("color")
        return string.color(color)
      end
      string
    end
  end
end