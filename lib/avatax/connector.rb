module Avatax
  class Connector
    def initialize
      @connection = Faraday.new(url: Avatax.configuration.base_url) do |faraday|
        faraday.request :json
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
