name "common_core"
default_source :supermarket

# Attributes
#
default[:ntp][:servers] = %w(
  0.amazon.pool.ntp.org
  1.amazon.pool.ntp.org
  2.amazon.pool.ntp.org
  3.amazon.pool.ntp.org
)

default[:common][:packages].tap do |config|
  config["awscli"] = true
  config["ec2-api-tools"] = true
  config["git-core"] = true
  config["python-setuptools"] = true
  config["python-virtualenv"] = true
  config["python-pip"]        = true
  config["python-docutils"]   = true
  config["ruby"] = true
  config["ruby1.9.1-dev"] = true
end

default[:common][:auth][:group][:managed][:kibana] = true

default[:common][:linux].tap do |config|
  config[:sudoers][:ubuntu].tap do |sudoer|
    sudoer[:user] = "ubuntu"
    sudoer[:runas] = "root"
    sudoer[:nopasswd] = true
  end

  config[:sudoers][:deploy].tap do |sudoer|
    sudoer[:group] = "deploy"
    sudoer[:runas] = "root"
    sudoer[:nopasswd] = true
    sudoer[:commands] = ["/usr/bin/chef-client"]
  end

  config[:sudoers]["90-cloud-init-users"].tao do |sudoer|
    sudoer[:action] = :remove
  end
end

default[:authorization][:sudo][:groups] = %w(devops)
default[:openssh][:server][:allow_groups] = %w(devops deploy vagrant)

run_list("common_core::default")
cookbook "common_core",   path: "."
cookbook "common_linux",  path: "../common_linux"
cookbook "common_auth",   path: "../common_auth"
cookbook "common_utils",  path: "../common_utils"
cookbook "rsyslog_ng",    path: "../rsyslog_ng"

