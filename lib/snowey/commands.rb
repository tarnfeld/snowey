
module Snowey
  
  module Commands

    module ID
      def execute arguments
        tag = arguments[:tag]

        id = IDManager.generate tag
        Logger.message "Generated ID '#{id}' for tag '#{tag}'", Logger::DEBUG
        return id
      end
      module_function :execute
    end

    module INFO
      def execute arguments
        IDManager.info arguments[:tag]
      end
      module_function :execute
    end

    module STATUS
      def execute arguments
        # @TODO: Must implement this status method
        "STATUS INFO"
      end
      module_function :execute
    end
  end
end