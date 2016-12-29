module ActionDispatch
  module Routing
    class Mapper
      # Define a route that only recognizes HTTP LOCK.
      # For supported arguments, see match[rdoc-ref:Base#match]
      #
      #   lock 'bacon', to: 'food#bacon'
      def lock(*args, &block)
        map_method(:lock, args, &block)
      end

      # Define a route that only recognizes HTTP UNLOCK.
      # For supported arguments, see match[rdoc-ref:Base#match]
      #
      #   unlock 'bacon', to: 'food#bacon'
      def unlock(*args, &block)
        map_method(:unlock, args, &block)
      end
    end
  end
end
