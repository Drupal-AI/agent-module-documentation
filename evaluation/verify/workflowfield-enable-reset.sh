#!/usr/bin/env bash
# Execution RESET: ensure workflowfield is UNINSTALLED so verify FAILS until the agent enables it.
set -uo pipefail
cd /var/www/html
drush pmu workflowfield -y >/dev/null 2>&1
echo "reset: workflowfield uninstalled"
