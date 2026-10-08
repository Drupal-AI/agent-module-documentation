#!/usr/bin/env bash
# Execution CLEANUP: restore system.site:page.403 to its default (empty). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set system.site page.403 '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: system.site:page.403 cleared"
