#!/usr/bin/env bash
# Execution RESET (purge_purger_http_tagsheader): uninstall the submodule so the Purge-Cache-Tags
# header plugin is NOT registered (verify FAILS) until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx purge_purger_http_tagsheader; then
  drush pmu purge_purger_http_tagsheader -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "reset: purge_purger_http_tagsheader uninstalled"
