require 'spec_helper'

describe Avatax::Api::TaxRates, :vcr do
  let(:client) do
    Avatax::Client.new(
      username: ENV['AVATAX_USERNAME'],
      password: ENV['AVATAX_PASSWORD'],
      env: :sandbox
    )
  end

  let(:params) { Hash.new }
  let(:method) { nil }

  subject { client.tax_rates.get(method, params) }

  context 'when using by address method' do
    let(:method) { Avatax::Api::TaxRates::BY_ADDRESS_METHOD }
    let(:params) do
      {
        line1: '350 State St.',
        city: 'Salt Lake City',
        region: 'UT',
        postalCode: '84111',
        country: 'US'
      }
    end

    its(:success?) { is_expected.to eql true }
  end

  context 'when getting by postal code method' do
    let(:method) { Avatax::Api::TaxRates::BY_POSTAL_CODE_METHOD }
    let(:params) do
      { country: 'US', postalCode: '84111' }
    end

    its(:success?) { is_expected.to eql true }
  end

  context 'when using unkown method' do
    let(:method) { :invalid }
    it { expect { subject }.to raise_error ArgumentError }
  end
end
