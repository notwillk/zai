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

if ! pnpm install --frozen-lockfile --lockfile-only > /dev/null 2>&1; then
  echo "❌ pnpm lockfile is out of date with package.json"
  if [ "$FIX" = true ]; then
    echo "🛠  Regenerating lockfile..."
    pnpm install --lockfile-only
    echo "✅ Lockfile updated"
    exit 0
  fi
  exit 1
else
  echo "✅ pnpm lockfile is up to date with package.json"
fi
