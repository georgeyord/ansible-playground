#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")";

if [ -z $1 ]; then
  echo -e "You must provide the ssh arguments, for example:\n  ${0} ubuntu@1.2.3.4\n  ${0} -i ~/.ssh/super_secret.pem ubuntu@1.2.3.4"
  exit 1;
fi

ssh ${@} << EOF
  sudo apt update && \
  sudo apt install -y python-minimal
EOF
