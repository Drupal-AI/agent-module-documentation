#!/usr/bin/env bash
# Execution RESET: ensure NO dotenv .env fixture exists at the Composer root (so verify FAILS
# until the agent creates it). Backs up any pre-existing real .env. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if [ -f .env ] && ! grep -q '# dotenv-eval-fixture' .env; then
  mv -f .env .env.dotenv-eval.bak
fi
rm -f .env .env.local.php
echo "reset: no .env present at /var/www/html"
