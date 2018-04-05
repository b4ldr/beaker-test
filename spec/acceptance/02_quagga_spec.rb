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
      describe command("vtysh -c 'show ip bgp sum'") do
        its(:stdout) { is_expected.to match(%r{10.255.0.1\s+4\s+40528}) }
      end
      default['prefix'].each do |prefix|
        describe command("vtysh -c 'show ip bgp neighbors 10.255.0.1 advertised-routes'") do
          its(:stdout) { is_expected.to match(%r{#{prefix}\s+#{default.ip}}) }
        end
      end
    end
  end
end
