#!/usr/bin/env bash
# Introspection CLEANUP: uninstall then remove the probe module (uninstall BEFORE deleting the
# directory to avoid an orphaned enabled module). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall block_form_alter_probe -y >/dev/null 2>&1
rm -rf web/modules/custom/block_form_alter_probe
drush cr >/dev/null 2>&1
echo "cleanup: block_form_alter_probe removed"
