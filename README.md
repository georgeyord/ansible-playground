> **Ansible** is one of the simplest ways to automate the setup of IT infrastructure.
> Ansible = Application Deployment + Configuration Management + Continuous Delivery

# Installation

1. In ansible host, run the following script to prepare to run `ansible` commands:

```
./scripts/init_local.sh
```

2. Run the following script on *each* of the Debian servers to prepare them to run ansible playbooks:

```
./scripts/init_remote.sh -i [SSH_KEY] [USER]@[IP]
```

3. Copy public key to targets to be abel to login without a password:

```
ssh-copy-id pi@[IP]
```

4. Change default password to improve security _(optional)_:

```
ssh pi@[IP] passwd
```

5. Gather the following information per ansible target:
```
- name, eg dev_machine_1
- IP, eg 1.2.3.4
- user, eg john
- ssh key to use, eg  ~/.ssh/id_rsa
```

When you are done you should be able to run `ssh -i [SSH_KEY] [USER]@[IP]` and log in each of the servers.

6. Copy `hosts.example.ini` to `hosts.ini` and use the information gathered above to describe your servers. For example it could be as simple as this:
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

# First usage example

To use it go to the repo root folder and run a command like:

```
ansible-playbook demo.yaml --limit swarm_staging_1
```

> Try it out on your own, this command is harmless!
> To learn more about what this playbook is executing check [this file](roles/demo/tasks/main.yml).

You can run also ad-hoc commands like this one which prints out all IP addresses for the remote server:
```
ansible swarm_staging_1 -m shell -a "hostname -I"
```

> Try it out, this command is also harmless!
> If something is not correct, check the Troubleshooting section below.

# Folder structure

Root folder hosts:

- `scripts` folder some helping scripts you may have already used
- `hosts.example.ini`, an example file to use to create your `hosts.ini`
- `hosts.ini` which describes your servers
- the diferent playbooks (files ending in `.yaml`)
- `roles` folder to host the play definitions activated by the playbooks above

# Hints and tips on usage

- Ansible provides 2 commands: `ansible` for custom commands and `ansible-playbook` to run playbooks
- To target to specific servers add: `--limit swarm_staging_1`
- To target to a specific tag add: `--tag config`

# Troubleshooting

## Missing ssh key

If you don't have an ssh key locally (`ls ~/.ssh/id*` returns `No such file or directory`) consider creating one as described in this [link](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

## Could not match supplied host pattern

`hosts.ini` is describing our servers and is linked to `/etc/ansible/hosts`. Check that both of these have the correct configuration.

```
cat hosts.ini # should contain your server setup
cat /etc/ansible/hosts # should contain exactly the same content
```

> If something is not correct, try following again the Installation section above.
