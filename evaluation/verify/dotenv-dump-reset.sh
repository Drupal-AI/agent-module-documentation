#!/usr/bin/env bash
# Execution RESET for the dotenv:dump task: create a .env at the Composer root (APP_ENV=prod) and
# ensure NO compiled .env.local.php exists yet (so verify FAILS until the agent runs dotenv:dump).
# Backs up any pre-existing real .env. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if [ -f .env ] && ! grep -q '# dotenv-eval-fixture' .env; then
  mv -f .env .env.dotenv-eval.bak
fi
printf '# dotenv-eval-fixture\nAPP_ENV=prod\nDOTENV_DUMP_KEY=dumpme\n' > .env
rm -f .env.local.php
echo "reset: /var/www/html/.env present (APP_ENV=prod), .env.local.php absent"
