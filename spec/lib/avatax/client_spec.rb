require 'spec_helper'

describe Avatax::Client do
  let(:client) do
    Avatax::Client.new(
      username: 'user_good',
      password: 'pass_good',
      env: :sandbox
    )
  end

  subject { client }

  it { is_expected.to respond_to :subscriptions }
  it { is_expected.to respond_to :users }
  it { is_expected.to respond_to :accounts }
  it { is_expected.to respond_to :addresses }
  it { is_expected.to respond_to :batches }
  it { is_expected.to respond_to :companies }
  it { is_expected.to respond_to :transactions }
  it { is_expected.to respond_to :contacts }
  it { is_expected.to respond_to :items }
  it { is_expected.to respond_to :locations }
  it { is_expected.to respond_to :nexus }
  it { is_expected.to respond_to :settings }
  it { is_expected.to respond_to :tax_codes }
  it { is_expected.to respond_to :tax_rules }
  it { is_expected.to respond_to :upcs }
  it { is_expected.to respond_to :definitions }
  it { is_expected.to respond_to :tax_rates }
  it { is_expected.to respond_to :utilities }
end
