#!/usr/bin/env bash
# Introspection SETUP: put og.settings (the config the og_ui OG settings form edits) into a
# known NON-default state - orphan deletion on with the cron strategy, group manager full
# access off - so the agent must read the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("og.settings")
    ->set("delete_orphans", TRUE)
    ->set("delete_orphans_plugin_id", "cron")
    ->set("group_manager_full_access", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: og.settings delete_orphans=TRUE plugin=cron group_manager_full_access=FALSE"
