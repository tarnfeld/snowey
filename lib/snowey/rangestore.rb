
module Snowey
  
  module RangeStore
    @auth = OPT_AUTH # Name of store to use
    @size = OPT_SIZE # Size of allocations
    attr_accessor :auth, :size

    class OutOfRange < Error; end
    class InvalidAuthenticatonParam < Error; end

    def store
      return @store if @store
      type = @auth.match(/([a-zA-Z]*)\:/)[1]
      store_class = "Store#{type.capitalize}"
      store = const_get(store_class)
      @store = store.new @size, @auth
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

    class Store
      def initialize size, auth
        raise NotImplementedError.new
      end

      def allocate tag
        raise NotImplementedError.new
      end
    end

    class StoreRedis < Store
      def initialize size, auth
        auth = auth.match(/^[a-z]+\:\/\/([\w\.]+)(:([\d]+))?(\/([\d]+))?/i)
        @size = size
        @host = auth[1] || (raise InvalidAuthenticatonParam.new "Host auth param is missing")
        @port = auth[3] || (raise InvalidAuthenticatonParam.new "Port auth param is missing")
        @db = auth[5]

        connect
      end

      def allocate tag
        key = "snowey::range::#{tag}"
        inc = @redis.incrby key, @size

        Range.new inc, inc+@size
      end

      def connect
        Logger.message "Connecting to redis on #{@host}:#{@port}", Logger::DEBUG
        @redis = Redis.new(:host => @host, :port => @port)
        if @db
          Logger.message "Switching to redis db #{@db}", Logger::DEBUG
          @redis.select @db
        end
      end
    end

    class StoreDynamo < Store
      # Some methods here for interacting with the data store and allocating a new range
      # I'm not sure if ruby has interfaces but we should have that shorta thing for these store classes
    end
  end
end