module Avatax
  module Api
    class TaxRates < Base
      BY_ADDRESS_METHOD = :by_address
      BY_POSTAL_CODE_METHOD = :by_postal_code

      VALID_METHODS = [BY_ADDRESS_METHOD, BY_POSTAL_CODE_METHOD]

      def get(method, args = {})
        unless VALID_METHODS.include?(method.to_sym)
          raise ArgumentError, 'method must be one of :bt_address or :by_postal_code'
        end

        handle_response(send("get_#{method}", args))
      end

      private

      def get_by_address(args)
        connection.get '/api/v2/taxrates/byaddress', args
      end

      def get_by_postal_code(args)
        connection.get '/api/v2/taxrates/bypostalcode', args
      end
    end
  end
end
