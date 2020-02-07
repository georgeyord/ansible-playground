#!/bin/bash
### PURPOSE ###
# - Check that pre-requisites are installed
# - Create ansible configuration folder
# - Create soft links between ansible configuration

set -e

cd "$(dirname "${BASH_SOURCE}")";

type python >/dev/null 2>&1 || \
  { echo >&2 "Python is required for ansible to run, please install it and re-try."; exit 2; }
type ansible >/dev/null 2>&1 || \
  { echo >&2 "Ansible binary is required for ansible to run, please install it and re-try."; exit 2; }

cd ..
sudo mkdir -p /etc/ansible

if [ ! -f /etc/ansible/hosts ]; then
  echo "Create a soft link from '$(pwd)/hosts.ini' to '/etc/ansible/hosts'"
  sudo ln -s "$(pwd)/hosts.ini" "/etc/ansible/hosts"
fi

if [ ! -f /etc/ansible/ansible.cfg ]; then
  echo "Create a soft link from '$(pwd)/ansible.cfg' to '/etc/ansible/ansible.cfg'"
  sudo ln -s "$(pwd)/ansible.cfg" "/etc/ansible/ansible.cfg"
fi

echo "All OK!"
