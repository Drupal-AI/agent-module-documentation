#!/usr/bin/env bash
# hook_post_action_example execution RESET (uninstall case): ensure it is ENABLED so verify (which
# wants it gone) fails on this starting state.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx hook_post_action_example; then
  drush en hook_post_action_example -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "reset: hook_post_action_example enabled (starting state)"
