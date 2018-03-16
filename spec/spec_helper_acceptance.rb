# frozen_string_literal: true

require 'beaker-rspec'
require 'progressbar'


# Install Puppet on all hosts
hosts.each do |host|
  step "install packages on #{host}"
  host.install_package('git')
  # remove search list and domain from resolve.conf
  on(host, 'printf "nameserver 8.8.8.8" > /etc/resolv.conf')
  step 'install puppet'
end
RSpec.configure do |c|
  c.formatter = :documentation
  # c.before :suite do
  #   hosts.each do |host|
  #   end
  # end
end
