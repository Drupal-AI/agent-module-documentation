#!/usr/bin/env bash
# Execution RESET: remove any previously-built subscriber module and clear the state marker so
# verify FAILS on empty state. CRITICAL: uninstall the module BEFORE deleting its directory to
# avoid an orphaned enabled module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
if drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx entity_events_ins; then
  drush pmu entity_events_ins -y >/dev/null 2>&1
fi
rm -rf web/modules/custom/entity_events_ins
drush php:eval '\Drupal::state()->delete("entity_events_ins.last");' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: entity_events_ins module removed, state entity_events_ins.last cleared"
