#!/usr/bin/env bash
# Introspection CLEANUP: uninstall monitoring_multigraph (removes its multigraphs; baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall monitoring_multigraph -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: monitoring_multigraph uninstalled (baseline)"
