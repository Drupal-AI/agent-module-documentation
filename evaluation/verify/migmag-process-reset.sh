#!/usr/bin/env bash
# Execution RESET: uninstall migmag_process (+ dependents) so its plugins/stub service are absent
# and verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
for m in migmag_menu_link_migrate migmag_process_lookup_replace migmag_process; do
  drush pm:list --status=enabled --format=list 2>/dev/null | grep -qx "$m" && drush pmu "$m" -y >/dev/null 2>&1
done
drush cr >/dev/null 2>&1
echo "reset: migmag_process (and dependents) uninstalled"
