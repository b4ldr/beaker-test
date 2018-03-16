# frozen_string_literal: true

require 'beaker-rspec'
require 'progressbar'


puppet_install_script = 'https://iad01.master.dns.icann.org:8140/packages/current/install.bash'

# Install Puppet on all hosts
hosts.each do |host|
  step "install packages on #{host}"
  on(host, 'printf "nameserver 8.8.8.8" > /etc/resolv.conf')
  step 'install puppet'
  on(host, "/usr/bin/curl -k #{puppet_install_script} | /bin/bash") 
end
RSpec.configure do |c|
  c.formatter = :documentation
  # c.before :suite do
  #   hosts.each do |host|
  #   end
  # end
end
