#!/usr/bin/env bash
# Execution RESET: create a known active config object (config_partial_export.cpex_task) and
# make sure it is NOT present in the config sync directory, so verify FAILS until the agent
# exports it with the module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_partial_export.cpex_task")->set("marker", "cpex-task-marker")->save();' >/dev/null 2>&1
SYNC=$(drush ev 'print \Drupal::service("file_system")->realpath(\Drupal\Core\Site\Settings::get("config_sync_directory"));' 2>/dev/null)
[ -n "$SYNC" ] && rm -f "$SYNC/config_partial_export.cpex_task.yml"
echo "reset: active config_partial_export.cpex_task present; sync file removed from $SYNC"
