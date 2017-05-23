module Avatax
  module Api
    ##
    # Transactions client
    # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/
    #
    class Transactions < Base
      ##
      # Get all transactions within a company.
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2CompaniesByCompanyCodeTransactionsGet
      #
      # @param company_code [String] The company_code in avatax.
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def all(company_code, args = {})
        raise ArgumentError, 'company_code is required' if company_code.blank?

        resp = connection.get "/api/v2/companies/#{company_code}/transactions/", args
        handle_response(resp)
      end

      ##
      # Get a transaction by code
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2CompaniesByCompanyCodeTransactionsByTransactionCodeGet
      #
      # @param company_code [String] The company_code in avatax.
      # @param transaction_code [String] The avatax transaction code.
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def find_by_code(company_code, transaction_code, args = {})
        raise ArgumentError, 'company_code is required' if company_code.blank?
        raise ArgumentError, 'transaction_code is required' if transaction_code.blank?

        resp = connection.get "/api/v2/companies/#{company_code}/transactions/#{transaction_code}", args
        handle_response(resp)
      end

      ##
      # Get a transaction by code
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2TransactionsByIdGet
      #
      # @param company_code [String] The company_code in avatax.
      # @param transaction_code [String] The avatax transaction ID.
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def find_by_id(transaction_id, args = {})
        raise ArgumentError, 'transaction_id is required' if transaction_id.blank?

        resp = connection.get "/api/v2/transactions/#{transaction_id}", args
        handle_response(resp)
      end

      ##
      # Adjust a transaction
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2CompaniesByCompanyCodeTransactionsByTransactionCodeAdjustPost
      #
      # @param company_code [String] The company_code in avatax.
      # @param transaction_code [String] The avatax transaction code.
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def adjust(company_code, transaction_code, args = {})
        post_for(:adjust, company_code, transaction_code, args)
      end

      ##
      # Change a transaction code
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2CompaniesByCompanyCodeTransactionsByTransactionCodeChangecodePost
      #
      # @param company_code [String] The company_code in avatax.
      # @param transaction_code [String] The current avatax transaction code.
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def change_code(company_code, transaction_code, args = {})
        post_for(:changecode, company_code, transaction_code, args)
      end

      ##
      # Commit a transaction
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2CompaniesByCompanyCodeTransactionsByTransactionCodeCommitPost
      #
      # @param company_code [String] The company_code in avatax.
      # @param transaction_code [String] The current avatax transaction code.
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def commit(company_code, transaction_code, args = {})
        args.reverse_merge(commit: true)
        post_for(:commit, company_code, transaction_code, args)
      end

      ##
      # Settle a transaction
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2CompaniesByCompanyCodeTransactionsByTransactionCodeSettlePost
      #
      # @param company_code [String] The company_code in avatax.
      # @param transaction_code [String] The current avatax transaction code.
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def settle(company_code, transaction_code, args = {})
        post_for(:settle, company_code, transaction_code, args)
      end

      ##
      # Verify a transaction
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2CompaniesByCompanyCodeTransactionsByTransactionCodeVerifyPost
      #
      # @param company_code [String] The company_code in avatax.
      # @param transaction_code [String] The current avatax transaction code.
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def verify(company_code, transaction_code, args = {})
        post_for(:verify, company_code, transaction_code, args)
      end

      ##
      # Void a transaction
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2CompaniesByCompanyCodeTransactionsByTransactionCodeVoidPost
      #
      # @param company_code [String] The company_code in avatax.
      # @param transaction_code [String] The current avatax transaction code.
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def void(company_code, transaction_code, args = {})
        args.reverse_merge!(code: Avatax::Code::DOC_VOIDED)
        post_for(:void, company_code, transaction_code, args)
      end

      ##
      # Create a transaction
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#ApiV2TransactionsCreatePost
      #
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def create(args = {})
        resp = connection.post '/api/v2/transactions/create', args
        handle_response(resp)
      end

      ##
      # Create or Adjust a transaction if transaction already exists.
      # @see https://developer.avalara.com/avatax/api-reference/tax/v2/Transactions/#CreateOrAdjustTransaction
      #
      # @param args [Hash] Arguments for avatax.
      # @return [Avatax::Response]
      #
      def create_or_adjust(args = {})
        resp = connection.post '/api/v2/transactions/createoradjust', args
        handle_response(resp)
      end

      private

      def post_for(endpoint, company_code, transaction_code, args)
        raise ArgumentError, 'company_code is required' if company_code.blank?
        raise ArgumentError, 'transaction_code is required' if transaction_code.blank?

        resp = connection.post "/api/v2/companies/#{company_code}/transactions/#{transaction_code}/#{endpoint}", args
        handle_response(resp)
      end
    end
  end
end
