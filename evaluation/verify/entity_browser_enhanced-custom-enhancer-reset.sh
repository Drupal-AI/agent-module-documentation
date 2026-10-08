#!/usr/bin/env bash
# Execution RESET: remove any previously built ebe_zoom enhancer module so the
# entity_browser_enhanced_plugin definition ebe_zoom does NOT exist; verify must FAIL here.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu ebe_zoom_enhancer -y >/dev/null 2>&1
rm -rf /var/www/html/web/modules/custom/ebe_zoom_enhancer
drush cr >/dev/null 2>&1
echo "reset: ebe_zoom_enhancer module uninstalled and removed"
