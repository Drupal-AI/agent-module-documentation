#!/usr/bin/env bash
# next_jsonapi introspection SETUP: ensure next_jsonapi is enabled so its decoration is observable.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx next_jsonapi; then
  drush en next_jsonapi -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "setup: next_jsonapi enabled"
