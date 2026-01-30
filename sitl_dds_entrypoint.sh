#!/bin/bash

# Start MicroXRCE Agent in background
echo "Starting MicroXRCE-DDS Agent on UDP port 8888..."
MicroXRCEAgent udp4 -p 8888 &

git config --global --add safe.directory '*'

exec "$@"
