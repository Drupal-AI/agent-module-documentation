#!/usr/bin/env bash
# hook_post_action execution RESET: remove hpa_probe2 (pmu BEFORE rm) and clear its state key.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx hpa_probe2; then
  drush pmu hpa_probe2 -y >/dev/null 2>&1 || true
fi
rm -rf web/modules/custom/hpa_probe2
drush state:delete hpa_probe2_last_update >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: hpa_probe2 absent, state hpa_probe2_last_update cleared"
