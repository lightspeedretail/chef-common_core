# common_core cookook

A cookbook used as a base role which will pull in other cookbooks. On it's own, it really should do absolutly nothing except include other cookbooks. 

## Included cookbooks

### common_attrs

A cookbook which provides helper methods that streamline various attribute related workflows. A few of the highlights include loading environment attributes from (potentially encrypted) databags, support for attribute namespaces, secrets management and attribute blacklisting. 

[link](https://supermarket.chef.io/cookbooks/common_attrs)

### common_linux

A cookbook which performs various standard linux system configuration tasks such as setting the hostname or the timezone as well as installing packages. 

[link](https://supermarket.chef.io/cookbooks/common_linux)

### common_auth

A cookbook which will manage users, groups, openssh and sudo. 

[link](https://supermarket.chef.io/cookbooks/common_auth)

