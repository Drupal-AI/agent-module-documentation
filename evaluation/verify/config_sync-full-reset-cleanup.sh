#!/usr/bin/env bash
# Execution CLEANUP: remove the config_sync.update_mode state key (back to default merge).
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush state:delete config_sync.update_mode >/dev/null 2>&1
echo "cleanup: config_sync.update_mode deleted (default merge)"
