#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped og.settings defaults for the three keys the
# matching setup changed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("og.settings")
    ->set("delete_orphans", FALSE)
    ->set("delete_orphans_plugin_id", "simple")
    ->set("group_manager_full_access", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: og.settings restored to delete_orphans=FALSE plugin=simple group_manager_full_access=TRUE"
