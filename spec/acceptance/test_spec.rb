# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'puppet install' do
  context 'defaults' do
    let(:args) { '--no-daemonize -v -t -o --environment 206_genral_erros' }
    it 'is_expected.to work with no errors' do
      run_agent_on(default, args)
    end
  end
end
