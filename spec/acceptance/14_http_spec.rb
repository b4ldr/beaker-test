# frozen_string_literal: true

if default['roles'].include?('http')

  require 'spec_helper_acceptance'
  curl_cmd = 'curl -I --include --insecure -o -'
  describe 'Testing HTTP configueration' do
    default['http'].each_pair do |domain, config|
      context "check #{domain}" do
        describe service(config['service']) do
          it { is_expected.to be_running }
        end
        if config['http']
          describe port(80) do
            it { is_expected.to be_listening }
          end
          config['uris'].each do |uri|
            describe command("#{curl_cmd} http://#{domain}/#{uri}") do
              its(:stdout) { is_expected.to match(%r{HTTP/1\.1\s+200\s+OK}) }
            end
          end
        end
        if config['https']
          describe port(443) do
            it { is_expected.to be_listening }
          end
          config['uris'].each do |uri|
            describe command("#{curl_cmd} https://#{domain}/#{uri}") do
              its(:stdout) { is_expected.to match(%r{HTTP/1\.1\s+200\s+OK}) }
            end
          end
        end
      end
    end
  end
end
