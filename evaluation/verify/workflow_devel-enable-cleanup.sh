#!/usr/bin/env bash
# Execution CLEANUP: uninstall workflow_devel to restore baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush pmu workflow_devel -y >/dev/null 2>&1
echo "cleanup: workflow_devel uninstalled"
