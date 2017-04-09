module Avatax
  module Api
    class Addresses < Base
      ##
      # Validate an address
      # @see http://developer.avalara.com/avatax/api-reference/tax/v2/Addresses/#ApiV2AddressesResolvePost
      #
      def validate(args = {})
        resp = connection.post '/api/v2/addresses/resolve', args
        handle_response(resp)
      end
    end
  end
end
