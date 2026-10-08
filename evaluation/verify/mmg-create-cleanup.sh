#!/usr/bin/env bash
# Execution CLEANUP: uninstall monitoring_multigraph (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall monitoring_multigraph -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: monitoring_multigraph uninstalled (baseline)"
