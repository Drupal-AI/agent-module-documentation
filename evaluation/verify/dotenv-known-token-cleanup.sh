#!/usr/bin/env bash
# Introspection CLEANUP: remove the dotenv fixture .env and restore any backed-up real one.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if [ -f .env ] && grep -q '# dotenv-eval-fixture' .env; then
  rm -f .env
fi
if [ -f .env.dotenv-eval.bak ]; then
  mv -f .env.dotenv-eval.bak .env
fi
echo "cleanup: dotenv fixture .env removed"
