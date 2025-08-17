#!/usr/bin/env bash
set -euo pipefail

RUNNER_FILENAME="_script_runner.sh"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASENAME="$(basename "$0")"
TARGET_DIR="$SCRIPT_DIR/${BASENAME}s"

if [ "$BASENAME" = "$RUNNER_FILENAME" ]; then
  # Find symlinks in the current dir that point to _script_runner.sh
  names=()
  for f in "$SCRIPT_DIR"/*; do
    [ -L "$f" ] || continue
    t=$(readlink "$f" || true)
    # Match either exact relative or basename match (handles absolute/relative)
    if [ "$t" = "$RUNNER_FILENAME" ] || [ "$(basename "$t")" = "$RUNNER_FILENAME" ]; then
      names+=("$(basename "$f")")
    fi
  done

  echo "❌ Cannot run directly, try one of: ${names[*]}" >&2

  exit 1
fi

for SCRIPT in "$TARGET_DIR"/*.sh; do
  if [ -f "$SCRIPT" ]; then
    echo "🩺 Running $SCRIPT $*"
    "$SCRIPT" "$@"
  fi
done
