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

cookbook "common_core",   path: "."
cookbook "common_linux",  path: "../common_linux"
cookbook "common_auth",   path: "../common_auth"
cookbook "common_attrs",  path: "../common_attrs"
cookbook "rsyslog_ng",    path: "../rsyslog_ng"

