#!/usr/bin/env bash
# Execution RESET: ensure the enhanced integration links submodule is UNINSTALLED so verify
# FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu acquia_dam_integration_links -y >/dev/null 2>&1 || true
echo "reset: acquia_dam_integration_links uninstalled"
