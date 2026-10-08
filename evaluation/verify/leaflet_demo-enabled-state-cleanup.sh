#!/usr/bin/env bash
# Introspection CLEANUP: uninstall leaflet_demo, restoring the shared site's baseline (it
# ships disabled by default; leaflet_more_maps itself is untouched). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall leaflet_demo -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: leaflet_demo uninstalled (baseline restored)"
