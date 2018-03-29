# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'puppet install' do
  context 'defaults' do
    let(:args) { '--no-daemonize -t -o --environment 206_genral_erros' }
    it 'run puppet and make changes' do
      run_agent_on(default, args, acceptable_exit_codes: [2])
    end
    it 'run puppet second run to converge' do
      run_agent_on(default, args, acceptable_exit_codes: [2])
    end
    it 'Clean puppet run' do
      run_agent_on(default, args, acceptable_exit_codes: [2])
    end
  end
end
