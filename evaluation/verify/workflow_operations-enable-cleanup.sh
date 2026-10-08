#!/usr/bin/env bash
# Execution CLEANUP: uninstall workflow_operations to restore baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu workflow_operations -y >/dev/null 2>&1
echo "cleanup: workflow_operations uninstalled"
