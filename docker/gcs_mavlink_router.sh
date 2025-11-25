#!/bin/bash

GCS_TARGET_IP=${GCS_TARGET_IP:-host.docker.internal}
TARGET_IP=$(getent hosts $GCS_TARGET_IP | awk '{print $1}')
if [ -n "$TARGET_IP" ]; then
  mavp2p udps:0.0.0.0:14550 udpc:$TARGET_IP:14550 > /tmp/mavp2p.log 2>&1 &
fi
