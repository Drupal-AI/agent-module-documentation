#!/usr/bin/env bash
# Execution CLEANUP: uninstall the delete-subscriber module (before removing its dir) and clear
# state, leaving the site clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx entity_events_del; then
  drush pmu entity_events_del -y >/dev/null 2>&1
fi
rm -rf web/modules/custom/entity_events_del
drush php:eval '\Drupal::state()->delete("entity_events_del.last");' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: entity_events_del removed, state cleared"
