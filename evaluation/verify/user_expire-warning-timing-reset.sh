#!/usr/bin/env bash
# Execution RESET: restore default warning timing (offset=604800 / 7d, frequency=172800 / 2d)
# so verify FAILS until the agent changes both. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set user_expire.settings offset 604800 -y >/dev/null 2>&1
drush config:set user_expire.settings frequency 172800 -y >/dev/null 2>&1
echo "reset: offset=604800, frequency=172800 (defaults)"
