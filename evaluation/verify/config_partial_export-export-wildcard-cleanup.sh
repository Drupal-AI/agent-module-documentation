#!/usr/bin/env bash
# Execution CLEANUP: remove the two sync files and active configs for the wildcard case.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
SYNC=$(drush ev 'print \Drupal::service("file_system")->realpath(\Drupal\Core\Site\Settings::get("config_sync_directory"));' 2>/dev/null)
if [ -n "$SYNC" ]; then
  rm -f "$SYNC/config_partial_export.cpex_wca.yml" "$SYNC/config_partial_export.cpex_wcb.yml"
fi
drush php:eval '
  \Drupal::configFactory()->getEditable("config_partial_export.cpex_wca")->delete();
  \Drupal::configFactory()->getEditable("config_partial_export.cpex_wcb")->delete();
' >/dev/null 2>&1
echo "cleanup: config_partial_export.cpex_wca / cpex_wcb configs and sync files removed"
