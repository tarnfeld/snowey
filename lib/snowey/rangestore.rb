
module Snowey
  
  module RangeStore
    TYPE_REDIS = "StoreRedis"
    TYPE_DYNAMO = "StoreDynamo"

    @type = OPT_STORE # Name of store to use
    @size = OPT_SIZE # Size of allocations
    @auth = {} # Authentication credentials for the store type

    class OutOfRange < Error; end

    def store
      p @type
      p @size
      p @auth
      StoreRedis.new
    end
    module_function :store

    class Range
      attr_reader :start, :end, :pointer

      def initialize rstart, rend
        @start = rstart
        @end = rend
        @pointer = @start

        @alive = true
      end

      def alive?
        @alive = @pointer + 1 <= @end
      end

      def next
        raise OutOfRange.new "Cannot advance a dead range" if !alive?
        @pointer = @pointer + 1
      end
    end

    class StoreRedis
      def allocate
        Range.new 100, 200
      end
      # Some methods here for interacting with the data store and allocating a new range
      # I'm not sure if ruby has interfaces but we should have that shorta thing for these store classes
    end

    class StoreDynamo
      # Some methods here for interacting with the data store and allocating a new range
      # I'm not sure if ruby has interfaces but we should have that shorta thing for these store classes
    end
  end
end