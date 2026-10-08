#!/usr/bin/env bash
# Introspection CLEANUP: uninstall THEN remove the probe module (avoid orphaned module).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall pluginformalter_probe -y >/dev/null 2>&1
rm -rf web/modules/custom/pluginformalter_probe
drush cr >/dev/null 2>&1
echo "cleanup: pluginformalter_probe removed"
