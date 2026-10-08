#!/usr/bin/env bash
# hook_post_action execution CLEANUP: uninstall + remove hpa_probe2 (pmu BEFORE rm), clear state.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx hpa_probe2; then
  drush pmu hpa_probe2 -y >/dev/null 2>&1 || true
fi
rm -rf web/modules/custom/hpa_probe2
drush state:delete hpa_probe2_last_update >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: hpa_probe2 removed, state cleared"
