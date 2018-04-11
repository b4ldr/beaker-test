# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'test users have been created correctly' do
  real_users = ['davids', 'jbond', 'terry', 'mvergara', 'karad']
  script_users = ['dns0ps', 'peadmin']
  real_users.each do |real_user|
    context "Test Real user #{real_user}" do
      describe user(real_user) do
        it { is_expected.to exist }
        it { is_expected.to belong_to_group 'sudo' }
        it { is_expected.to have_home_directory "/home/#{real_user}" }
        its(:encrypted_password) { is_expected.to match(/^\$6\$.{8}\$.{86}$/) }
      end
    end
  end
  script_users.each do |script_user|
    context "Test script user #{script_user}" do
      describe user(script_user) do
        it { is_expected.to exist }
        it { is_expected.to belong_to_group 'sudo' }
        it { is_expected.to have_home_directory "/home/#{real_user}" }
        its(:encrypted_password) { is_expected.to eq '!' }
      end
    end
  end
end
