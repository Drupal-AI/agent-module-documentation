#!/usr/bin/env bash
# next_jwt introspection SETUP: ensure next_jwt enabled so its jwt plugin is discoverable.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx next_jwt; then
  drush en next_jwt -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "setup: next_jwt enabled"
