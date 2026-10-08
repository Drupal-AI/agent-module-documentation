#!/usr/bin/env bash
# Execution CLEANUP: uninstall workflow_ui to restore baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu workflow_ui -y >/dev/null 2>&1
echo "cleanup: workflow_ui uninstalled"
