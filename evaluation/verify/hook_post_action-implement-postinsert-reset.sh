#!/usr/bin/env bash
# hook_post_action execution RESET: remove the hpa_probe module (uninstall BEFORE deleting its dir,
# to avoid an orphaned enabled module) and clear the state key so verify fails on empty state.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx hpa_probe; then
  drush pmu hpa_probe -y >/dev/null 2>&1 || true
fi
rm -rf web/modules/custom/hpa_probe
drush state:delete hpa_probe_last_insert >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: hpa_probe absent, state hpa_probe_last_insert cleared"
