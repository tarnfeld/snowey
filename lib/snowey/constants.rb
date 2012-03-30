
module Snowey

  # Default options
  OPT_ADDRESS = "0.0.0.0"
  OPT_PORT = 2478
  OPT_VERBOSE = true
  OPT_DEBUG = false
  OPT_AUTH = "redis://0.0.0.0:6379"
  OPT_SIZE = 1000

  class Error < StandardError; end
  
end
