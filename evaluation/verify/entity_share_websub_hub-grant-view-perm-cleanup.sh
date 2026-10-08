#!/usr/bin/env bash
# Execution CLEANUP: delete the eswhub_editor role, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete eswhub_editor >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role eswhub_editor deleted"
