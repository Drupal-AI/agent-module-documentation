#!/usr/bin/env bash
# Execution RESET: uninstall pagerer_example so its example route is gone and verify FAILS until
# the agent enables the module. Does NOT delete the module directory (contrib), so no orphaned
# module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx pagerer_example; then
  drush pmu pagerer_example -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "reset: pagerer_example uninstalled"
