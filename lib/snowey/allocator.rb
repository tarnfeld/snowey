
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
      @allocations[tag] = IDAllocator.new(tag)
    end
  end

  # Class for dealing ID allocation for a particular tag
  # It handles dishing out unique IDs and allocating new ranges to itself when it runs out
  class IDAllocator

    def initialize tag
      @tag = tag
      @store = RangeStore.store

      reallocate
    end

    def info
      # This no longer works, pull it out of the current @range
      "#{@tag} #{@range_start} : #{@range_end} @ #{@range_pointer}"
    end

    def next
      if !@range.alive?
        reallocate
      end

      # Add in the salt here?
      @range.next
    end

    def machine_identifier
      # Get the machine identifier
    end

    def prefix
      # Get the id prefix
    end

    def reallocate
      Logger.message "Allocating new range for tag '#{@tag}'", Logger::ALERT
      @range = @store.allocate
    end
  end
end
