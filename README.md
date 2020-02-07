A series of ansible playbooks to setup debian servers - mostly for testing

> **Ansible** is one of the simplest ways to automate the setup of IT infrastructure.
> Ansible = Application Deployment + Configuration Management + Continuous Delivery

## Installation

1. Run the following script to prepare to run `ansible`:

```
scripts/init_local.sh
```

2. Gather the following information per server:
```
- name, eg dev_machine_1
- IP, eg 1.2.3.4
- user, eg john
- ssh key to use, eg  ~/.ssh/id_rsa
```

When you are done you should be able to run `ssh -i [SSH_KEY] [USER]@[IP]` and log-in the server.

3. Copy `hosts.ini.example` to `hosts.ini` and use the information gathered above to describe your servers. For example it could be as simple as this:
```
[all:vars]
ansible_ssh_private_key_file = ~/.ssh/id_rsa

[debian:children]
dev_machines

[dev_machines]
dev_machine_1 ansible_host=1.2.3.4 ansible_user=john
```

The generic pattern is the follwoing:
```
[NAME] ansible_host=[IP] ansible_user=[USER]
```

## First usage example

To use it go to the repo root folder and run a command like:

```
ansible-playbook demo.yml --limit swarm_staging_1
```

Try it out on your own, this command is harmless!

You can run also ad-hoc commands like this one: `ansible swarm_staging_1 -m shell -a "hostname -I"`
Try it out, this command is harmless!
