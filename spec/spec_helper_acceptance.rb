# frozen_string_literal: true

require 'beaker-rspec'
require 'progressbar'


PUPPET_INSTALL_SCRIPT = 'https://iad01.master.dns.icann.org:8140/packages/current/install.bash'
AUTOSIGN_PASSWORD     = '2?h}8xtE}PyLXsY+=d2!'

# Install Puppet on all hosts
hosts.each do |host|
  step "install packages on #{host}"
  on(host, 'printf "nameserver 8.8.8.8" > /etc/resolv.conf')
  step 'install puppet'
  on(host, "/usr/bin/curl -k #{PUPPET_INSTALL_SCRIPT} | /bin/bash -s custom_attributes:challengePassword=#{AUTOSIGN_PASSWORD}") 
end
RSpec.configure do |c|
  c.formatter = :documentation
  # c.before :suite do
  #   hosts.each do |host|
  #   end
  # end
end
