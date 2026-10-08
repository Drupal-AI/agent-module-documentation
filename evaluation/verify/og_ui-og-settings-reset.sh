#!/usr/bin/env bash
# Execution RESET: restore the three og.settings keys the og_ui settings form controls to their
# shipped defaults (orphan deletion off, simple strategy, creators auto-added) so verify FAILS.
# Idempotent. Exit 0.
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
echo "reset: og.settings delete_orphans=FALSE plugin=simple auto_add_group_owner_membership=TRUE"
