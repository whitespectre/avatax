module Avatax
  class Client
    @@namespaces = []
    @@connection = nil

    ##
    # Defines a method to access class instance.
    #
    def self.namespace(name)
      converted = name.to_s.split('_').map(&:capitalize).join
      klass = Avatax::Api.const_get(converted)
      create_instance(klass)
    end

    ##
    # Dynamically creates an attr_reader for each client space
    # and sets it to the initalized values
    #
    def self.create_instance(klass)
      reader = klass.to_s.split('::').last.underscore
      @@namespaces << reader

      define_method(reader.to_sym) { klass.new @@connection }
    end

    namespace :accounts

    namespace :addresses

    namespace :batches

    namespace :companies

    namespace :contacts

    namespace :definitions

    namespace :items

    namespace :locations

    namespace :nexus

    namespace :settings

    namespace :subscriptions

    namespace :tax_codes

    namespace :tax_rates

    namespace :tax_rules

    namespace :transactions

    namespace :upcs

    namespace :users

    namespace :utilities

    def initialize(args = {})
      @configuration = Avatax::Configuration.new(args)

      @@connection = Faraday.new(url: @configuration.base_url) do |conn|
        conn.request :json
        conn.request(
          :basic_auth,
          @configuration.username,
          @configuration.password
        )

        conn.response :json
        conn.response :logger

        conn.adapter  Faraday.default_adapter
      end
    end
  end
end
