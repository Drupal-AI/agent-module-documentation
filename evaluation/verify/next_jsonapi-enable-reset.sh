#!/usr/bin/env bash
# next_jsonapi execution RESET (enable case): uninstall it so verify fails on empty state.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx next_jsonapi; then
  drush pmu next_jsonapi -y >/dev/null 2>&1 || true
fi
drush cr >/dev/null 2>&1
echo "reset: next_jsonapi uninstalled"
