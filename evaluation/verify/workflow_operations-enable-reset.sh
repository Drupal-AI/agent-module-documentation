#!/usr/bin/env bash
# Execution RESET: ensure workflow_operations is UNINSTALLED so verify FAILS until the agent enables it.
set -uo pipefail
cd /var/www/html
drush pmu workflow_operations -y >/dev/null 2>&1
echo "reset: workflow_operations uninstalled"
