#!/usr/bin/env bash
set -euo pipefail

#!/usr/bin/env bash
set -euo pipefail

GIT_NAME=$(git config user.name || true)
if [ -n "$GIT_NAME" ]; then
  echo "✅ Git name is set ($GIT_NAME)"
else
  echo "⚠️  Git name is not set"
fi

GIT_EMAIL=$(git config user.email || true)
if [ -n "$GIT_EMAIL" ]; then
  echo "✅ Git email is set ($GIT_EMAIL)"
else
  echo "⚠️  Git email is not set"
fi

SIGNING_KEY=$(git config user.signingkey || true)
if [ -n "$SIGNING_KEY" ]; then
  echo "✅ Git signing key is set ($SIGNING_KEY)"
else
  echo "⚠️  Git signing key is not set"
fi
