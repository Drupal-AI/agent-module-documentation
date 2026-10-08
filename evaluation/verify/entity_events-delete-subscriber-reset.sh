#!/usr/bin/env bash
# Execution RESET: remove any previously-built delete-subscriber module and clear its state
# marker so verify FAILS on empty state. Uninstall BEFORE deleting the directory. Idempotent.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx entity_events_del; then
  drush pmu entity_events_del -y >/dev/null 2>&1
fi
rm -rf web/modules/custom/entity_events_del
drush php:eval '\Drupal::state()->delete("entity_events_del.last");' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: entity_events_del module removed, state entity_events_del.last cleared"
