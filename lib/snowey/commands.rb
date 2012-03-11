
module Snowey
  
  module Commands

    module ID
      def execute arguments
        manager = IDManager.new
        manager.generate arguments[:tag]
      end
      module_function :execute
    end

    module INFO
      def execute arguments
        manager = IDManager.new
        manager.info arguments[:tag]
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