#!/usr/bin/env bash
# Execution RESET: remove the config_sync.update_mode state key so the mode is the default
# (Merge = 1), so verify FAILS until the agent switches it to Full reset (3). Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush state:delete config_sync.update_mode >/dev/null 2>&1
echo "reset: config_sync.update_mode unset (default merge)"
