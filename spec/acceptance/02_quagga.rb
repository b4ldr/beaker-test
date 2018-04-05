# frozen_string_literal: true

if default['roles'].include?('quagga')

  require 'spec_helper_acceptance'

  describe 'Testing routing configueration' do
    context 'check routing' do
      describe service('quagga') do
        it { is_expected.to be_running }
      end
      describe process('bgpd') do
        its(:user) { is_expected.to eq 'quagga' }
        it { is_expected.to be_running }
      end
      describe port(179) do
        it { is_expected.to be_listening }
      end
    end
  end
end
