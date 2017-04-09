module Avatax
  module Api
    class Base
      attr_reader :connection

      def initialize(connection)
        @connection = connection
      end

      protected

      def handle_response(response)
        response
      end
    end
  end
end
