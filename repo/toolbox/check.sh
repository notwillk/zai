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
  CHECKER=$(jq -r --arg tool "$TOOL" '.[$tool].check' "$TOOLS_JSON")
  VERSION=$(jq -r --arg tool "$TOOL" '.[$tool].version' "$TOOLS_JSON")
  CHECKER_CMD=$(echo "$CHECKER" | sed "s/\$version/$VERSION/Ig")
  echo "Checking $TOOL via: $CHECKER_CMD"
  if sh -c "$CHECKER_CMD" >/dev/null 2>&1; then
    echo "$TOOL: OK"
  else
    echo "$TOOL: NOT OK"
  fi
done
