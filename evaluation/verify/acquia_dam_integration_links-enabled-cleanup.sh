#!/usr/bin/env bash
# Execution CLEANUP: restore baseline for the documentation campaign (submodule uninstalled).
set -uo pipefail
cd /var/www/html
drush pmu acquia_dam_integration_links -y >/dev/null 2>&1 || true
echo "cleanup: acquia_dam_integration_links uninstalled (baseline)"
