#!/usr/bin/env bash
# Introspection CLEANUP: uninstall and delete the jqonce_probe fixture module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu jqonce_probe -y >/dev/null 2>&1
rm -rf /var/www/html/web/modules/custom/jqonce_probe
drush cr >/dev/null 2>&1
echo "cleanup: jqonce_probe module uninstalled and removed"
