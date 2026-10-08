#!/usr/bin/env bash
# Execution RESET: ensure workflow_ui is UNINSTALLED so verify FAILS until the agent enables it.
set -uo pipefail
cd /var/www/html
drush pmu workflow_ui -y >/dev/null 2>&1
echo "reset: workflow_ui uninstalled"
