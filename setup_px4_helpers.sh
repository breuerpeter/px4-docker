#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

SOURCE_LINE="source $SCRIPT_DIR/px4_helpers.sh"
if ! grep -qF "$SOURCE_LINE" ~/.bashrc 2>/dev/null; then
    echo "" >> ~/.bashrc
    echo "$SOURCE_LINE" >> ~/.bashrc
    echo "Added PX4 helpers to ~/.bashrc"
else
    echo "PX4 helpers already in ~/.bashrc"
fi
