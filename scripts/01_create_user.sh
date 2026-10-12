#!/bin/bash
: "${SVC_NAME:?Run: export SVC_NAME=bgdsvc_<nickname>}"
if id "$SVC_NAME" &>/dev/null; then
  echo "User $SVC_NAME already exists - skipping"
else
  sudo useradd -r -m -s /usr/sbin/nologin "$SVC_NAME" && echo "Created $SVC_NAME"
fi
id "$SVC_NAME"
getent passwd "$SVC_NAME"
