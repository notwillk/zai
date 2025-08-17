#!/usr/bin/env bash
set -euo pipefail

DEBUG=false
FIX=false

for arg in "$@"; do
  case "$arg" in
    --debug) DEBUG=true ;;
    --fix) FIX=true ;;
    *)
      echo "Unknown option: $arg" >&2
      exit 1
      ;;
  esac
done


SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/../../.."

REPO_PACKAGE_JSON="$ROOT_DIR/package.json"

SYSTEM_VERSION=$(pnpm --version)
ACTUAL_VERSION=$(jq -r '.packageManager // empty' "$REPO_PACKAGE_JSON")
EXPECTED_VERSION="pnpm@$SYSTEM_VERSION"

if [ "$EXPECTED_VERSION" != "$ACTUAL_VERSION" ]; then
  echo "❌ pnpm version does not match package.json (expected: $EXPECTED_VERSION, actual: $ACTUAL_VERSION)"

  if [ "$FIX" = true ]; then
    echo "🛠  Fixing package.json..."
    tmpfile=$(mktemp)
    jq --arg ver "$EXPECTED_VERSION" '.packageManager = $ver' \
      "$REPO_PACKAGE_JSON" > "$tmpfile"
    mv "$tmpfile" "$REPO_PACKAGE_JSON"
    echo "✅ Updated package.json to $EXPECTED_VERSION"
    exit 0
  else
    exit 1
  fi
else 
  echo "✅ pnpm version matches package.json ($SYSTEM_VERSION)"
fi
