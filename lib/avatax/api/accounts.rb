module Avatax
  module Api
    ##
    # Accounts Client
    # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Accounts/
    #
    class Accounts < Base
      ##
      # Activate an account
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Accounts/#ActivateAccount
      #
      # @param account_id [String, Integer] The ID of the account to activate.
      # @param args [Hash]  The arguments for avatax.
      # @return [Avatax::Response]
      #
      def activate(account_id, args = {})
        post_for(:activate, account_id, args)
      end

      ##
      # Get configuration for an account
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Accounts/#GetAccountConfiguration
      #
      # @param account_id [String, Integer] The ID of the account to activate.
      # @param args [Hash]  The arguments for avatax.
      # @return [Avatax::Response]
      #
      def configuration(account_id, args = {})
        get_for(:configuration, account_id, args)
      end

      ##
      # Update configuration for an account
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Accounts/#SetAccountConfiguration
      #
      # @param account_id [String, Integer] The ID of the account to activate.
      # @param args [Hash]  The arguments for avatax.
      # @return [Avatax::Response]
      #
      def update_configuration(account_id, args = {})
        post_for(:configuration, account_id, args)
      end

      ##
      # Reset the license key for an account.
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Accounts/#AccountResetLicenseKey
      #
      # @param account_id [String, Integer] The ID of the account to activate.
      # @param args [Hash]  The arguments for avatax.
      # @return [Avatax::Response]
      #
      def reset_license_key(account_id, args = {})
        post_for(:resetlicensekey, account_id, args)
      end

      ##
      # Get an account.
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Accounts/#GetAccount
      #
      # @param account_id [String, Integer] The ID of the account to activate.
      # @param args [Hash]  The arguments for avatax.
      # @return [Avatax::Response]
      #
      def get(account_id, args = {})
        get_for(nil, account_id, args)
      end

      private

      def get_for(endpoint, account_id, args)
        request_for(:get, endpoint, account_id, args)
      end

      def post_for(endpoint, account_id, args)
        request_for(:post, endpoint, account_id, args)
      end

      def request_for(method, endpoint, account_id, args)
        raise ArgumentError, 'account_id is required' if account_id.blank?

        resp = connection.send method, "/api/v2/accounts/#{account_id}/#{endpoint}", args
        handle_response(resp)
      end
    end
  end
end
