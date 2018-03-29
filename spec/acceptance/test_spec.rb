# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'puppet install' do
  context 'defaults' do
    let(:args) { '--no-daemonize -t -o --environment 206_genral_erros' }
    it 'run puppet and make changes' do
      expect(run_agent_on(default, args)).to eq 2
    end
    it 'run puppet clean' do
      expect(run_agent_on(default, args)).to eq 0
    end
  end
end
