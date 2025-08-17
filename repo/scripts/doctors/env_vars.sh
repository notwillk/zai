#!/usr/bin/env bash
set -euo pipefail

# Space-separated list
REQUIRED_ENV_VARS="REPO_SECRET_KEY"

for VAR in ${REQUIRED_ENV_VARS:-}; do
  if [ -z "$(printenv "$VAR" 2>/dev/null)" ]; then
    echo "⚠️  Warning: Missing required environment variable '$VAR'"
  else
    echo "✅  Environment variable '$VAR' is set"
  fi
done
