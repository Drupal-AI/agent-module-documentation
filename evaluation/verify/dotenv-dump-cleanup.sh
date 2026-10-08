#!/usr/bin/env bash
# Execution CLEANUP for the dotenv:dump task: remove fixture .env and compiled .env.local.php,
# restore any backed-up real .env. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f .env.local.php
if [ -f .env ] && grep -q '# dotenv-eval-fixture' .env; then rm -f .env; fi
if [ -f .env.dotenv-eval.bak ]; then rm -f .env; mv -f .env.dotenv-eval.bak .env; fi
echo "cleanup: dotenv:dump fixtures removed"
