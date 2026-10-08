#!/usr/bin/env bash
# hook_post_action_example execution RESET (enable case): uninstall it so verify fails on empty state.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx hook_post_action_example; then
  drush pmu hook_post_action_example -y >/dev/null 2>&1 || true
fi
drush cr >/dev/null 2>&1
echo "reset: hook_post_action_example uninstalled"
