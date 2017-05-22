require 'spec_helper'

describe Avatax::Configuration do
  let(:username) { 'user_good' }
  let(:password) { 'pass_good' }
  let(:env) { :sandbox }

  subject do
    Avatax::Configuration.new(
      username: username,
      password: password,
      env: env
    )
  end

  it { is_expected.to respond_to :sandbox }
  it { is_expected.to respond_to :base_url }
  it { is_expected.to respond_to :env }

  context 'when :username is missing' do
    let(:username) { nil }
    it { expect { subject }.to raise_error ArgumentError }
  end

  context 'when :password is missing' do
    let(:password) { nil }
    it { expect { subject }.to raise_error ArgumentError }
  end

  context 'when :env is missing' do
    let(:env) { nil }
    it { expect { subject }.to raise_error ArgumentError }
  end

  context 'when :env is neither :sandbox or :production' do
    let(:env) { :invalid }
    it { expect { subject }.to raise_error ArgumentError }
  end

  context 'when NOT in sandbox mode' do
    let(:env) { :production }

    its(:env) { is_expected.to eql Avatax::Configuration::PRODUCTION }
    its(:base_url) { is_expected.to eql Avatax::Configuration::REST_URLS[:production] }
  end

  context 'when in sandbox mode' do
    its(:env) { is_expected.to eql Avatax::Configuration::SANDBOX }
    its(:base_url) { is_expected.to eql Avatax::Configuration::REST_URLS[:sandbox] }
  end
end
