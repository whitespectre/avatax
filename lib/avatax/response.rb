module Avatax
  class Response < Faraday::Response
    def initialize(response)
      super()
      finish(response.env)
    end
  end
end
