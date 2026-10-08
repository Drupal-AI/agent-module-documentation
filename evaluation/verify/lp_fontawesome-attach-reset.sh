#!/usr/bin/env bash
# Execution RESET/CLEANUP for the lp_fontawesome "attach globally" cases. Uninstalls the custom
# module lp_fontawesome_attach (PMU BEFORE deleting its directory, to avoid an orphaned enabled
# module) and removes its directory, so no lp_fontawesome library is attached and verify FAILS.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx lp_fontawesome_attach; then
  drush pmu lp_fontawesome_attach -y >/dev/null 2>&1
fi
rm -rf web/modules/custom/lp_fontawesome_attach
drush cr >/dev/null 2>&1
echo "reset: lp_fontawesome_attach uninstalled and removed"
