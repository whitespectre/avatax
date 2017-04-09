require 'spec_helper'

describe Avatax::Api::Transactions, :vcr do
  let(:client) do
    Avatax::Client.new(
      username: ENV['AVATAX_USERNAME'],
      password: ENV['AVATAX_PASSWORD'],
      env: :sandbox
    )
  end

  let(:company_code) { 'DEFAULT' }
  let(:transaction_code) { 1 }
  let(:transaction_id) { 287826158 }
  let(:params) { Hash.new }

  describe '#all' do
    subject { client.transactions.all(company_code) }
    its(:success?) { is_expected.to eql true }
  end

  describe '#get_by_code' do
    subject { client.transactions.get_by_code(company_code, transaction_code) }
    its(:success?) { is_expected.to eql true }
  end

  describe '#get_by_id' do
    subject { client.transactions.get_by_id(transaction_id) }
    its(:success?) { is_expected.to eql true }
  end

  describe '#adjust' do
    subject do
      client.transactions.adjust(
        company_code,
        transaction_code,
        params
      )
    end

    its(:success?, :pending) { is_expected.to eql true }
  end

  describe '#change_code' do
    let(:params) do
      # Just update to itself
      { newCode: transaction_code }
    end

    subject do
      client.transactions.change_code(
        company_code,
        transaction_code,
        params
      )
    end

    its(:success?) { is_expected.to eql true }
  end

  describe '#commit' do
    subject do
      client.transactions.commit(
        company_code,
        transaction_code,
        params
      )
    end

    its(:success?) { is_expected.to eql true }
  end

  describe '#settle' do
    subject do
      client.transactions.settle(
        company_code,
        transaction_code,
        params
      )
    end

    its(:success?, :pending) { is_expected.to eql true }
  end

  describe '#verify' do
    subject do
      client.transactions.verify(
        company_code,
        transaction_code,
        params
      )
    end

    let(:params) do
      {
        verifyTransactionDate: '2017-04-09',
        verifyTotalAmount: '9.99',
        verifyTotalTax: '0.90'
      }
    end

    its(:success?) { is_expected.to eql true }
  end

  describe '#void' do
    subject do
      client.transactions.void(
        company_code,
        transaction_code,
        params
      )
    end

    its(:success?) { is_expected.to eql true }
  end

  describe '#create' do
    subject do
      client.transactions.create(params)
    end

    its(:success?, :pending) { is_expected.to eql true }
  end
end
