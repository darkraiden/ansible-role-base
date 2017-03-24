# Ansible Role Base

Base configurations, including users and groups, for RHEL and Debian systems.

## Dependencies

None

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

```
base_hostname: baseDefault
```

Hostname to be set on host.

```
base_global_envs: []
```

List of global environment variables to write into `/etc/environment` file.

```
base_add_groups: {}
```

This dictionary is used to add groups to the OS. It accepts the following parameters:

* **name** - name of the group to create (Required); and
* **gid** - GID to assign (Optional).

```
base_per_user_groups: True
```

Creates a group for each user using its own username as group name.

```
base_users: {}
```

This dictionary is used to add users to the OS. It accepts the following parameters:

* **username** - Username (Required);
* **group**    - The user's primary group used if `base_per_user_groups` is True;
* **groups**   - A list of groups the user will belong to (Optional);
* **password** - The user's password (Optional);
* **shell**    - The user's default shell - if not defined, `/bin/bash` will be assigned as default one;
* **name**     - User's name that will be written into the user's comment section (Optional);
* **uid**      - UID (Optional); and
* **home**     - Bool, create home for user - default value is `True`.

```
base_deleted_users: {}
```

This dictionary is used to delete users from your host. It accepts the following parameters:

* **username** - Username (Required).

**NB** If the user to delete is defined in `base_users`, remember to move it away from there before going ahead otherwise it'll always be created and destroyed every time.

```
base_alternatives: {}
```

This dictionary is used to set software alternatives. It accepts the following parameters:

* **name** - Name of the software; and
* **path** - Path to the binary.

```
base_lc_ctype: ""
base_lang: ""
```

Variables used to set the system locale, here's an example:

```
base_lc_ctype: en_GB
base_lang: "{{ base_lc_ctype }}.UTF-8
```

```
base_timezone: ""
```

Host's timezone (e.g. `UTC`).

```
base_ssh_port: [22]
base_ssh_listen_address: []
base_ssh_protocol: 2
base_ssh_grace_time: 20s
base_ssh_permit_root_login: 'no'
base_ssh_pubkey_authentication: 'yes'
base_ssh_password_authentication: 'no'
base_ssh_strict_modes: 'yes'
base_ssh_max_auth_tries: 3
base_ssh_max_sessions: 40
```

Variables used to generate the `sshd_config` file used by the SSH server.

```
base_utils_packages: []
```

List of utils you may want to install on your hosts.

### RedHat variables

```
base_ntp_package_name: "ntp"
```

Default ntp daemon package name on RHEL systems.

```
base_firewalld_bin_path: /usr/sbin/firewalld
base_disable_firewalld: True
```

Disable firewalld if `base_disable_firewalld` is `True` and if the firewall's binary file exists.

```
base_disable_selinux: True
```

Disable SELinux if this variable is True

```
base_ssh_service: sshd
```

Default name of SSH server daemon service.

### Debian Variables

```
base_ssh_service: ssh
```

Default name of SSH server daemon service.

## Handlers

The role comes with the following handlers:

* **restart ntpd** - It restarts the ntp daemon; and
* **restart ssh** - It restarts the ssh daemon.

## Example Playbook

```
- hosts: all
  roles:
    - ansible-role-base
```

## Test Kitchen

### Install Deps

```
$ bundle
```

### VMs

This kitchen configuration comes with 3 different VMs:

* centos7
* trusty
* xenial

If you want to test the role using all of those machines, just run the commands below as they are. If you want to test the role on one system only, append to the commands below the VM name.

e.g.

```
$ bundle exec kitchen converge trusty
```

To converge the `trusty` VM only.

### Create the VM

```
$ bundle exec kitchen create
```

### Converge your role

```
$ bundle exec kitchen converge
```

### Run serverspec tests

```
$ bundle exec kitchen verify
```

**NB**: To run `verify` the VM must be converged first.

### Destroy the VM

```
$ bundle exec kitchen destroy
```

### Run Create/Converge/Verify/Destroy in one command

```
$ bundle exec kitchen test
```

### Write your tests

You can write your own test by adding a new file or editing the existing one living in the `test/integration/base/serverspec/localhost` directory. More info about how to write serverspec test can be found [here](http://serverspec.org/).

## License

MIT (Expat) / BSD

## Author Information

This role was created in 2017 by [Davide Di Mauro](https://github.com/darkraiden).
