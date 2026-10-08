#!/usr/bin/env bash
# Execution RESET: uninstall dubbot_toolbar so verify FAILS until the agent enables it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu dubbot_toolbar -y >/dev/null 2>&1
echo "reset: dubbot_toolbar uninstalled"
