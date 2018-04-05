# frozen_string_literal: true

require 'beaker-rspec'
require 'progressbar'

PUPPET_ENV            = ENV.fetch('PUPPET_ENV','staging')
PUPPET_INSTALL_SCRIPT = 'https://iad01.master.dns.icann.org:8140/packages/current/install.bash'
SCRIPT_DIR = File.expand_path(File.dirname(__FILE__))
# Install Puppet on all hosts
hosts.each do |host|
  step "Update nameserver on #{host}"
  on(host, 'printf "nameserver 8.8.8.8" > /etc/resolv.conf')
  step "install puppet on #{host}"
  on(host, "/usr/bin/curl -k #{PUPPET_INSTALL_SCRIPT} | /bin/bash -s") 
  cert_source = File.join(SCRIPT_DIR, '..', 'ca', "#{host}.pem")
  key_source = File.join(SCRIPT_DIR, '..', 'ca', "#{host}.key")
  cert_dest = File.join(host.puppet['ssldir'], 'certs', "#{host}.pem")
  key_dest = File.join(host.puppet['ssldir'], 'private_keys', "#{host}.pem")
  step "delete #{cert_dest} and #{key_dest} generated during install"
  on(host, "rm -rf #{cert_dest} #{key_dest}")
  step "copy public key #{host}"
  scp_to(host, cert_source, cert_dest)
  step "copy private key #{host}"
  scp_to(host, key_source, key_dest)
end
RSpec.configure do |c|
  c.formatter = :documentation
end
