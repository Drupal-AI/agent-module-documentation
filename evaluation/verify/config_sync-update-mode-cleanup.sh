#!/usr/bin/env bash
# Introspection CLEANUP: remove the config_sync.update_mode state key so the module falls back
# to its default (Merge = 1). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush state:delete config_sync.update_mode >/dev/null 2>&1
echo "cleanup: state config_sync.update_mode deleted (default merge)"
