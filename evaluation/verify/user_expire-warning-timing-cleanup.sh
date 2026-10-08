#!/usr/bin/env bash
# Execution CLEANUP: restore default warning timing. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set user_expire.settings offset 604800 -y >/dev/null 2>&1
drush config:set user_expire.settings frequency 172800 -y >/dev/null 2>&1
echo "cleanup: offset=604800, frequency=172800 (baseline)"
