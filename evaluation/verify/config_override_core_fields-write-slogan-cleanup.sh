#!/usr/bin/env bash
# Execution CLEANUP: restore system.site:slogan to its default (empty). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set system.site slogan '' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: system.site:slogan cleared"
