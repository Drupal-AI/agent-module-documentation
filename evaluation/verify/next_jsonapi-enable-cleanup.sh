#!/usr/bin/env bash
# next_jsonapi execution CLEANUP (enable case): ensure enabled (documented baseline).
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx next_jsonapi; then
  drush en next_jsonapi -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "cleanup: next_jsonapi enabled (baseline)"
