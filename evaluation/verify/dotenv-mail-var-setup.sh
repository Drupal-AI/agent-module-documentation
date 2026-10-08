#!/usr/bin/env bash
# Introspection SETUP: write a known .env fixture containing a SITE_MAIL_FROM variable at the
# Composer root. Backs up any pre-existing non-fixture .env. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if [ -f .env ] && ! grep -q '# dotenv-eval-fixture' .env; then
  mv -f .env .env.dotenv-eval.bak
fi
printf '# dotenv-eval-fixture\nAPP_ENV=staging\nSITE_MAIL_FROM=alerts@probe.example\n' > .env
echo "setup: /var/www/html/.env has SITE_MAIL_FROM=alerts@probe.example"
