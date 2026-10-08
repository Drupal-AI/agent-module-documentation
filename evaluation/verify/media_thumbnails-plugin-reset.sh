#!/usr/bin/env bash
# Execution RESET: remove any previously built mt_probe module so the media_thumbnail plugin
# the agent must write does not exist yet.
# IMPORTANT: uninstall the module BEFORE deleting its directory - an enabled module whose
# directory is gone makes the kernel fatal. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall mt_probe -y >/dev/null 2>&1 || true
rm -rf /var/www/html/web/modules/custom/mt_probe
drush cr >/dev/null 2>&1
echo "reset: module mt_probe uninstalled and removed; plugin mt_probe_thumbnail absent"
