require 'spec_helper'

describe Avatax::Api::Addresses, :vcr do
  let(:client) do
    Avatax::Client.new(
      username: ENV['AVATAX_USERNAME'],
      password: ENV['AVATAX_PASSWORD'],
      env: :sandbox
    )
  end

  let(:params) do
    {
      line1: '350 State St.',
      city: 'Salt Lake City',
      region: 'UT',
      postalCode: '84111',
      country: 'US'
    }
  end

  describe '#validate' do
    subject { client.addresses.validate(params) }

    its(:success?) { is_expected.to eql true }
  end
end
