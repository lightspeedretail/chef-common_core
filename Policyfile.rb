name "common_core"
default_source :supermarket

default[:common_attrs][:environments][:active][:prepend] = %w()
default[:common_attrs][:namespaces][:active][:prepend] = %w()

default[:common_auth].tap do |auth|
  auth[:users][:data_bag] = "auth_users"
  auth[:groups][:data_bag] = "auth_groups"
  auth[:groups][:config][:devops][:action] = "create"

  auth[:sudoers][:ubuntu].tap do |sudoer|
    sudoer[:user] = "ubuntu"
    sudoer[:runas] = "root"
    sudoer[:nopasswd] = true
  end

  auth[:sudoers][:deploy].tap do |sudoer|
    sudoer[:group] = "deploy"
    sudoer[:runas] = "root"
    sudoer[:nopasswd] = true
    sudoer[:commands] = %w(/usr/bin/chef-client)
  end

  auth[:sudoers][:devops].tap do |sudoer|
    sudoer[:group] = "devops"
    sudoer[:runas] = "root"
  end

  auth[:sudoers][:vagrant].tap do |sudoer|
    sudoer[:group] = "vagrant"
    sudoer[:runas] = "root"
    sudoer[:nopasswd] = true
  end

  auth[:sudoers]["90-cloud-init-users"].tap do |sudoer|
    sudoer[:action] = "remove"
  end
end

default[:openssh][:server][:allow_groups] = %w(devops deploy vagrant)

run_list %w(common_core::default)

cookbook 'common_core',   path: '.'
cookbook 'common_linux',
    git: 'git@github.com:lightspeedretail/chef-common_linux.git',
    tag: 'v0.6.0'
cookbook 'common_auth',
    git: 'git@github.com:lightspeedretail/chef-common_auth.git',
    tag: 'v0.2.1'
cookbook 'common_attrs',
    git: 'git@github.com:lightspeedretail/chef-common_attrs.git',
    tag: 'v0.4.6'
cookbook 'rsyslog_ng',
    git: 'git@github.com:lightspeedretail/chef-rsyslog_ng.git',
    tag: 'v2.1.1'
