#!/usr/bin/env bash
# Execution CLEANUP: delete httpswww.settings, restoring the shipped baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:delete httpswww.settings >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: httpswww.settings deleted (restored to shipped baseline)"
