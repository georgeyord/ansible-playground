A series of ansible playbooks to setup debian servers - mostly for testing

> **Ansible** is one of the simplest ways to automate the setup of IT infrastructure.
> Ansible = Application Deployment + Configuration Management + Continuous Delivery

## Installation

Run the following script to prepare to run `ansible`:

```
scripts/init_local.sh
```

Copy `hosts.ini.example` to `hosts.ini` to describe your servers. For example it could be as simple as this:
```
[all:vars]
ansible_ssh_private_key_file = ~/.ssh/id_rsa

[debian:children]
dev_machines

[dev_machines]
dev_machine_1 ansible_host=1.2.3.4 ansible_user=john
```
