#!/usr/bin/env bash
# HARD execution reset for config_perms: remove any custom_perms_entity that gates the
# cron settings route so the task starts from a missing (failing) state. Clears the ids the
# verify script would accept as well as any entity already pointing at system.cron_settings.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("custom_perms_entity");
  foreach (["manage_cron_settings", "cron_settings_perm", "manage_cron"] as $id) {
    if ($e = $storage->load($id)) { $e->delete(); }
  }
  foreach ($storage->loadMultiple() as $e) {
    if (strpos((string) $e->getRoute(), "system.cron_settings") !== FALSE) { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed custom_perms_entity entities gating system.cron_settings (if any)"
