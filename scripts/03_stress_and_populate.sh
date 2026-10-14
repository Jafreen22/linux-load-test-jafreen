#!/bin/bash
: "${SVC_NAME:?Set SVC_NAME first}"
MNT="/mnt/${SVC_NAME}_tmp"

disk() {
  for i in $(seq 1 30); do
    sudo -u "$SVC_NAME" dd if=/dev/urandom of="$MNT/file_$i.dat" bs=1M count=10
    df -h "$MNT" | tail -1
  done
}
cpu() {
  if command -v stress-ng >/dev/null; then
    (cd /tmp && sudo -u "$SVC_NAME" stress-ng --cpu 2 --timeout 30s)
  else
    yes >/dev/null & p1=$!
    yes >/dev/null & p2=$!
    sleep 30; kill $p1 $p2
  fi
}
mem() { (cd /tmp && sudo -u "$SVC_NAME" stress-ng --vm 1 --vm-bytes 200M --timeout 30s); }

case "$1" in
  --cpu)  cpu ;;
  --mem)  mem ;;
  --disk) disk ;;
  --all)  cpu & mem & disk; wait ;;
  *) echo "Usage: $0 --cpu | --mem | --disk | --all"; exit 1 ;;
esac
