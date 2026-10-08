#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure the module is UNINSTALLED so verify FAILS until the agent
# enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu mercury_editor_inline_editor -y >/dev/null 2>&1
echo "reset: mercury_editor_inline_editor uninstalled (disabled)"
