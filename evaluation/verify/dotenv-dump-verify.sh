#!/usr/bin/env bash
# Execution VERIFY for "compile .env into .env.local.php with drush dotenv:dump".
# PASS when /var/www/html/.env.local.php exists and references the dumped variable.
# Pure file check. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
if [ -f .env.local.php ] && grep -q 'APP_ENV' .env.local.php; then
  echo "PASS .env.local.php compiled by dotenv:dump"
  exit 0
fi
echo "FAIL .env.local.php missing (run: drush dotenv:dump prod)"
exit 1
