#!/usr/bin/env bash
# Execution RESET: ensure workflow_devel is UNINSTALLED so verify FAILS until the agent enables it.
set -uo pipefail
cd /var/www/html
drush pmu workflow_devel -y >/dev/null 2>&1
echo "reset: workflow_devel uninstalled"
