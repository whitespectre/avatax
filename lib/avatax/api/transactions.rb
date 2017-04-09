module Avatax
  module Api
    class Transactions < Base
      def all(company_code, args = {})
        raise ArgumentError, 'company_code is required' if company_code.blank?

        resp = connection.get "/api/v2/companies/#{company_code}/transactions/", args
        handle_response(resp)
      end

      def get_by_code(company_code, transaction_code, args = {})
        raise ArgumentError, 'company_code is required' if company_code.blank?
        raise ArgumentError, 'transaction_code is required' if transaction_code.blank?

        resp = connection.get "/api/v2/companies/#{company_code}/transactions/#{transaction_code}", args
        handle_response(resp)
      end

      def get_by_id(transaction_id, args = {})
        raise ArgumentError, 'transaction_id is required' if transaction_id.blank?

        resp = connection.get "/api/v2/transactions/#{transaction_id}", args
        handle_response(resp)
      end

      def adjust(company_code, transaction_code, args = {})
        post_for(:adjust, company_code, transaction_code, args)
      end

      def change_code(company_code, transaction_code, args = {})
        post_for(:changecode, company_code, transaction_code, args)
      end

      def commit(company_code, transaction_code, args = {})
        post_for(:commit, company_code, transaction_code, args.reverse_merge(commit: true))
      end

      def settle(company_code, transaction_code, args = {})
        post_for(:settle, company_code, transaction_code, args)
      end

      def verify(company_code, transaction_code, args = {})
        post_for(:verify, company_code, transaction_code, args)
      end

      def void(company_code, transaction_code, args = {})
        post_for(:void, company_code, transaction_code, args.reverse_merge(code: 3))
      end

      def create(args = {})
        resp = connection.post '/api/v2/transactions/create', args
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
