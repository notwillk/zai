#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/../../.."

REPO_PACKAGE_JSON="$ROOT_DIR/package.json"

SYSTEM_VERSION=$(pnpm --version)
ACTUAL_VERSION=$(jq -r '.packageManager // empty' "$REPO_PACKAGE_JSON")
EXPECTED_VERSION="pnpm@$SYSTEM_VERSION"

if [ "$EXPECTED_VERSION" != "$ACTUAL_VERSION" ]; then
  echo "❌ pnpm version does not match package.json (expected: $EXPECTED_VERSION, actual: $ACTUAL_VERSION)"
  exit 1
fi

echo "✅ pnpm version matches package.json ($SYSTEM_VERSION)"