module Avatax
  class Configuration
    attr_reader :sandbox, :base_url, :env, :username, :password, :headers,
                :logger

    REST_URLS = {
      sandbox:    'https://sandbox-rest.avatax.com',
      production: 'https://rest.avatax.com'
    }

    SANDBOX = :sandbox
    PRODUCTION = :production

    def initialize(args = {})
      validate_args(args)

      @env = args[:env].to_sym
      @sandbox = @env == SANDBOX
      @base_url = REST_URLS[env]

      @headers = args[:headers] || {}

      @username = args[:username]
      @password = args[:password]

      @logger = args[:logger] || Logger.new(STDOUT)
    end

    private

    def validate_args(args)
      if args[:headers].try(:[], :authorization).blank?
        raise ArgumentError, 'username is required' if args[:username].blank?
        raise ArgumentError, 'password is required' if args[:password].blank?
      end
      raise ArgumentError, 'env is required' if args[:env].blank?

      return if [SANDBOX, PRODUCTION].include?(args[:env].to_sym)
      raise ArgumentError, 'env must be of :sandbox or :production'
    end
  end
end
