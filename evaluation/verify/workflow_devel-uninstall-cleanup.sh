#!/usr/bin/env bash
# Execution CLEANUP: leave workflow_devel uninstalled (baseline). Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu workflow_devel -y >/dev/null 2>&1
echo "cleanup: workflow_devel uninstalled"
