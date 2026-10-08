#!/usr/bin/env bash
# Execution CLEANUP: remove the sync file and active config for the single-export case.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
SYNC=$(drush ev 'print \Drupal::service("file_system")->realpath(\Drupal\Core\Site\Settings::get("config_sync_directory"));' 2>/dev/null)
[ -n "$SYNC" ] && rm -f "$SYNC/config_partial_export.cpex_task.yml"
drush php:eval '\Drupal::configFactory()->getEditable("config_partial_export.cpex_task")->delete();' >/dev/null 2>&1
echo "cleanup: config_partial_export.cpex_task config and sync file removed"
