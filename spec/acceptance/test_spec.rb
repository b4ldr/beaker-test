# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'knot class' do
  context 'defaults' do
    it 'is_expected.to work with no errors' do
      pp = 'notify {$::fqdn: }'
      execute_manifest(pp, catch_failures: true)
      expect(execute_manifest(pp, catch_failures: true).exit_code).to eq 0
    end
  end
end
