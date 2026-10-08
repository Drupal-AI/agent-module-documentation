#!/usr/bin/env bash
# Execution RESET: uninstall rest_views_geo so its formatter is absent (verify FAILS).
set -uo pipefail
cd /var/www/html
drush pmu rest_views_geo -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: rest_views_geo uninstalled"
