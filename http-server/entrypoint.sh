#!/bin/bash

exec /usr/sbin/sshd -D

exec /usr/bin/python3 -m http.server --directory /files 80 &