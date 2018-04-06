# frozen_string_literal: true

if default['roles'].include?('dns')

  require 'spec_helper_acceptance'

  describe 'Testing DNS configueration' do
    default['dns'].each_pair do |zone_set, config|
      context "check #{zone_set} Zone Set @#{config['address']}" do
        describe service(config['service']) do
          it { is_expected.to be_running }
        end
        describe port(53) do
          it { is_expected.to be_listening }
        end
        config['zones'].each do |zone| 
          describe command("dig +short soa #{zone} @#{config['address']}") do
            its(:stdout) do
              is_expected.to match(
                %r{[a-z\-\.]+\s[a-z\-\.]+\s\d+\s\d+\s\d+\s\d+\s\d+} 
              )
            end
          end
        end
      end
    end
  end
end
