# Load gem
require 'avatax'

# Load Test Libraries
require 'rspec'
require 'rspec/its'
require 'vcr'
require 'webmock'
require 'pry'

# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

##
# This is only needed for testing locally. Will attempt to load a file
# `/spec/env.yml` containing any environment variables needed.
#
file_path = File.join(__dir__, 'env.yml')
if File.exist?(file_path)
  YAML.load_file(file_path).each do |key, value|
    ENV[key] ||= value
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<BASIC_AUTH>') do |interaction|
    interaction.request.headers['Authorization'].first
  end
end

RSpec.configure do |config|
  config.color = true
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.formatter = :documentation

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end
