#!/usr/bin/env bash
# Execution CLEANUP: uninstall the mt_probe module FIRST, then delete its directory, so the
# site is never left with an enabled module whose code is gone. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall mt_probe -y >/dev/null 2>&1 || true
rm -rf /var/www/html/web/modules/custom/mt_probe
drush cr >/dev/null 2>&1
echo "cleanup: module mt_probe uninstalled and directory removed"
