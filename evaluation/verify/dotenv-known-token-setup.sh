#!/usr/bin/env bash
# Introspection SETUP: write a known .env fixture at the Composer root so an inspecting agent
# can read back a dotenv variable value. Backs up any pre-existing .env that is NOT our fixture.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if [ -f .env ] && ! grep -q '# dotenv-eval-fixture' .env; then
  mv -f .env .env.dotenv-eval.bak
fi
printf '# dotenv-eval-fixture\nAPP_ENV=staging\nDOTENV_PROBE_TOKEN=probe-9f3a7c\nDB_NAME=db\n' > .env
echo "setup: /var/www/html/.env has DOTENV_PROBE_TOKEN=probe-9f3a7c (APP_ENV=staging)"
