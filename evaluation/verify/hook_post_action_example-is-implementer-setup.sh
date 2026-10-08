#!/usr/bin/env bash
# hook_post_action_example introspection SETUP: ensure it is enabled so the agent can discover it.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx hook_post_action_example; then
  drush en hook_post_action_example -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "setup: hook_post_action_example enabled"
