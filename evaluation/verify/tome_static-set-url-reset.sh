#!/usr/bin/env bash
# Execution RESET: clear the tome_static.url state key so verify FAILS until the agent sets it
# to the required value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sdel tome_static.url >/dev/null 2>&1
echo "reset: tome_static.url cleared"
