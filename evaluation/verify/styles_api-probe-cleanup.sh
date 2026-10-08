#!/usr/bin/env bash
# Introspection CLEANUP: uninstall then remove the probe module (uninstall BEFORE deleting the
# directory to avoid an orphaned enabled module). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall styles_api_probe -y >/dev/null 2>&1
rm -rf web/modules/custom/styles_api_probe
drush cr >/dev/null 2>&1
echo "cleanup: styles_api_probe removed"
