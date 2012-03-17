
module Snowey

  # Module for managing the various IDAllocation objects for each tag in the global scope
  # All calls for generating IDs should be via the IDManager
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

  # Class for dealing ID allocation for a particular tag
  # It handles dishing out unique IDs and allocating new ranges to itself when it runs out
  class IDAllocation

    def initialize tag
      @tag = tag
      @range_start = @range_end = @range_pointer = 0

      reallocate
    end

    def info
      "#{@tag} #{@range_start} : #{@range_end} @ #{@range_pointer}"
    end

    def next
      if (@range_pointer+1) > @range_end
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

      @range_start = @range_end
      @range_end = @range_end + 10
      @range_pointer = @range_start
    end
  end
end
