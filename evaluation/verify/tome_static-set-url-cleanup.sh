#!/usr/bin/env bash
# Execution CLEANUP: delete the tome_static.url state key to restore baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush sdel tome_static.url >/dev/null 2>&1
echo "cleanup: tome_static.url deleted"
