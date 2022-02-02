#!/bin/bash

set -e

# Make sure scripts in /opt/env are usable:
#export PATH="/opt/env/bin:${PATH}"
#export LD_LIBRARY_PATH="$/opt/env/lib:${LD_LIBRARY_PATH}"

# Start uwsgi
#/usr/sbin/sshd -D
#status=$?
#if [ $status -ne 0 ]; then
#  echo "Failed to start SSHD: $status"
#  exit $status
#fi

/usr/bin/python3 -m http.server --directory /files 80
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start Python Web Server: $status"
  exit $status
fi