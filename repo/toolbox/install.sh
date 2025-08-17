#!/bin/sh

SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)/$(basename "$0")"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

TOOLS_JSON="$SCRIPT_DIR/tools.json"

if [ ! -f "$TOOLS_JSON" ]; then
  echo "Error: $TOOLS_JSON not found."
  exit 1
fi

TOOLS=$(jq -r 'keys[]' "$TOOLS_JSON" | grep -v '^$' | grep -v '^\$' | tr '\n' ' ')

for TOOL in $TOOLS; do
  INSTALLER=$(jq -r --arg tool "$TOOL" '.[$tool].installer' "$TOOLS_JSON")
  VERSION=$(jq -r --arg tool "$TOOL" '.[$tool].version' "$TOOLS_JSON")
  INSTALL_CMD=$(echo "$INSTALLER" | sed "s/\$version/$VERSION/Ig")
  echo "Installing $TOOL via: $INSTALL_CMD"
  sh -c "$INSTALL_CMD"
done
