#!/usr/bin/env bash
# Execution CLEANUP: delete the entire add_to_head.settings config object created by the
# agent's build, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:delete add_to_head.settings >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: add_to_head.settings deleted"
