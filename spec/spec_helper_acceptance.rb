# frozen_string_literal: true

require 'beaker-rspec'
require 'progressbar'

PUPPET_ENV            = ENV.fetch('PUPPET_ENV','staging')
PUPPET_INSTALL_SCRIPT = 'https://iad01.master.dns.icann.org:8140/packages/current/install.bash'
SCRIPT_DIR = File.expand_path(File.dirname(__FILE__))
# Install Puppet on all hosts
hosts.each do |host|
  step "#{host}: Update nameserver on"
  on(host, 'printf "nameserver 8.8.8.8" > /etc/resolv.conf')
  step "#{host}: install puppet on"
  on(host, "/usr/bin/curl -k #{PUPPET_INSTALL_SCRIPT} | /bin/bash -s") 
  cert_source = File.join(SCRIPT_DIR, '..', 'ca', "#{host}.pem")
  key_source = File.join(SCRIPT_DIR, '..', 'ca', "#{host}.key")
  cert_dest = File.join(host.puppet['ssldir'], 'certs', "#{host}.pem")
  key_dest = File.join(host.puppet['ssldir'], 'private_keys', "#{host}.pem")
  step "#{host}: delete #{cert_dest} and #{key_dest} generated during install"
  on(host, "rm -rf #{cert_dest} #{key_dest}")
  step "#{host}: copy public key"
  scp_to(host, cert_source, cert_dest)
  step "#{host}: copy private key"
  scp_to(host, key_source, key_dest)
  step "#{host}: Install apparmor-utils on"
  host.install_package('apparmor-utils')
end
RSpec.configure do |c|
  c.formatter = :documentation
end
