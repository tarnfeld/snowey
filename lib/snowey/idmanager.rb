
module Snowey

  module IDManager
    @allocations = {}

    def generate tag
      allocation = self::allocation(tag)
      allocation.next
    end

    def info tag
      allocation = self::allocation(tag)
      allocation.info
    end

    module_function :generate
    module_function :info

    private

    def self.allocation tag
      return @allocations[tag] if @allocations.has_key?(tag)
      @allocations[tag] = IDAllocation.new(tag)
    end
  end

  class IDAllocation

    def initialize tag
      @tag = tag
      @range_start = @range_end = @range_pointer = 0

      reallocate
    end

    def info
      "#{@tag} #{@range_start}:#{@range_end}@#{@range_pointer}"
    end

    def next
      if (@range_pointer + 1) > @range_end
        reallocate
      end
      @range_pointer += 1
    end

    def machine_identifier
      # Get the machine identifier
    end

    def prefix
      # Get the id prefix
    end

    def reallocate
      Logger.message "Allocating new range for tag '#{@tag}'", Logger::ALERT
      # Re-allocate a new range
    end
  end
end
