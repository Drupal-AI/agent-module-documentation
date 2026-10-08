#!/usr/bin/env bash
# Execution RESET: uninstall migmag_rollbackable (+ its replace dependent) so its destination
# plugins and rollback tables are absent and verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
for m in migmag_rollbackable_replace migmag_rollbackable; do
  drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx "$m" && drush pmu "$m" -y >/dev/null 2>&1
done
drush cr >/dev/null 2>&1
echo "reset: migmag_rollbackable (and replace) uninstalled"
