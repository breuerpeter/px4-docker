#!/bin/bash

EXCLUDE_FILE="$(dirname "$0")/../.git/info/exclude"
PATTERN="docker/"

mkdir -p "$(dirname "$EXCLUDE_FILE")"

if [ -f "$EXCLUDE_FILE" ] && grep -qxF "$PATTERN" "$EXCLUDE_FILE"; then
    echo "\"$PATTERN\" already in $EXCLUDE_FILE"
else
    echo "$PATTERN" >> "$EXCLUDE_FILE"
    echo "Added \"$PATTERN\" to $EXCLUDE_FILE"
fi
