#!/usr/bin/env bash
# Execution VERIFY for "create a .env with APP_ENV=prod and DOTENV_TASK_KEY=taskvalue123".
# PASS when /var/www/html/.env exists and contains both APP_ENV=prod and
# DOTENV_TASK_KEY=taskvalue123. Pure file check (no drush bootstrap needed).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
if [ -f .env ] && grep -Eq '^APP_ENV=prod$' .env && grep -Eq '^DOTENV_TASK_KEY=taskvalue123$' .env; then
  echo "PASS .env present with APP_ENV=prod and DOTENV_TASK_KEY=taskvalue123"
  exit 0
fi
echo "FAIL .env missing or does not contain the required keys"
exit 1
