#!/bin/bash
cd /home/z/my-project
while true; do
  PORT=3000 HOSTNAME=0.0.0.0 node .next/standalone/server.js
  echo "Process exited, restarting in 2 seconds..." >&2
  sleep 2
done
