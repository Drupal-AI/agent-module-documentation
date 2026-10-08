#!/usr/bin/env bash
# Execution CLEANUP: uninstall workflowfield to restore baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu workflowfield -y >/dev/null 2>&1
echo "cleanup: workflowfield uninstalled"
