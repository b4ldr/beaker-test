# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'Basic services' do
  context 'SSHd' do
    describe port(22) do
      it { is_expected.to be_listening }
    end
    describe process('sshd') do
      its(:user) { is_expected.to eq 'root' }
    end
  end
  context 'NRPE' do
    describe port(5666) do
      it { is_expected.to be_listening }
    end
    describe process('nrpe') do
      its(:user) { is_expected.to eq 'nagios' }
    end
  end
  context 'NTPd' do
    describe process('ntpd') do
      its(:user) { is_expected.to match(/_?ntp/) }
    end
  end
  context 'Zabbix Agent' do
    describe port(10050) do
      it { is_expected.to be_listening }
    end
    describe process('zabbix_agentd') do
      its(:user) { is_expected.to eq 'zabbix' }
    end
  end
end
