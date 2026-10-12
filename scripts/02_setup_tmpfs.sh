#!/bin/bash
: "${SVC_NAME:?Set SVC_NAME first}"
MNT="/mnt/${SVC_NAME}_tmp"
sudo mkdir -p "$MNT"
if mountpoint -q "$MNT"; then
  echo "Already mounted"
else
  sudo mount -t tmpfs -o size=256M tmpfs "$MNT"
fi
sudo chown "$SVC_NAME:$SVC_NAME" "$MNT"
df -h "$MNT"
