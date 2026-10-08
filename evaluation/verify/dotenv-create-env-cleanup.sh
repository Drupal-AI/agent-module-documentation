#!/usr/bin/env bash
# Execution CLEANUP: remove the dotenv fixture .env / .env.local.php and restore any backup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f .env.local.php
if [ -f .env ] && grep -q '# dotenv-eval-fixture' .env; then rm -f .env; fi
# The create-env task writes a plain .env (no sentinel); remove it too if it only holds task keys.
if [ -f .env ] && grep -Eq '^DOTENV_TASK_KEY=' .env && ! [ -f .env.dotenv-eval.bak ]; then rm -f .env; fi
if [ -f .env.dotenv-eval.bak ]; then rm -f .env; mv -f .env.dotenv-eval.bak .env; fi
echo "cleanup: dotenv create-env fixture removed"
