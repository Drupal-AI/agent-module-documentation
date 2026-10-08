#!/usr/bin/env bash
# Execution CLEANUP: uninstall monitoring_prometheus (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall monitoring_prometheus -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: monitoring_prometheus uninstalled (baseline)"
