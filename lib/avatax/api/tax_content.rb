module Avatax
  module Api
    class TaxContent < Base
      ##
      # Download taxrates by zipcode
      # @param date [Date] The date to get taxrates for
      # @param args [Hash] The query to send along
      # @options args [String] :region - The two character abbreviation for region
      # @param on_data [Proc] - A lambda to run when data is received (For Streaming)
      #
      def download_tax_rates_by_zipcode(date, args = {}, on_data = nil)
        response = connection.get do |request|
          request.url "/api/v2/taxratesbyzipcode/download/#{date}"
          request.params = args
          request.options.on_data = on_data if on_data
        end

        return if on_data

        handle_response(response)
      end

      private

      def format_date(date)
        date.strftime('%Y-%m-%d')
      end
    end
  end
end
