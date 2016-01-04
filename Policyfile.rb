name "common_core"

default_source :supermarket

run_list(
  "common_core::default"
)

cookbook "common_core",   path: "."
cookbook "common_linux",  path: "../common_linux"
cookbook "common_auth",   path: "../common_auth"
cookbook "common_utils",  path: "../common_utils"
cookbook "rsyslog_ng",    path: "../rsyslog_ng"

