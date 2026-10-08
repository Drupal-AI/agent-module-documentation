#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped default (disabled=0, protection ON). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset disable_user_1_edit.settings disabled 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: disabled=0 restored (protection ON)"
