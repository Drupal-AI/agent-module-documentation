#!/usr/bin/env bash
# Execution RESET: uninstall the experimental tome_sync_autoclean submodule so verify FAILS
# until the agent enables it. Idempotent. Exit 0. (Module install/uninstall triggers a full
# container rebuild and can take ~1-2 minutes.)
set -uo pipefail
cd /var/www/html
drush pmu tome_sync_autoclean -y >/dev/null 2>&1
echo "reset: tome_sync_autoclean uninstalled"
