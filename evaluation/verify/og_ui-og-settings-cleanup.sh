#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped og.settings defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("og.settings")
    ->set("delete_orphans", FALSE)
    ->set("delete_orphans_plugin_id", "simple")
    ->set("auto_add_group_owner_membership", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: og.settings restored to shipped defaults"
