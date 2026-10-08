#!/usr/bin/env bash
# Execution RESET: uninstall leaflet_demo so it is disabled (verify MUST fail until the agent
# enables it). leaflet_more_maps itself is untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall leaflet_demo -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: leaflet_demo uninstalled"
