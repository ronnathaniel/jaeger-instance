#!/bin/bash

ssh -i ~/Downloads/lupa-load-testing-pk.pem "ec2-user@$1" << EOF
  ./setup_local.sh
EOF
