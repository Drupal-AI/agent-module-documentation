#!/usr/bin/env bash
# Execution RESET: create two known active config objects sharing a prefix
# (config_partial_export.cpex_wca / cpex_wcb) and ensure neither is present in the config sync
# directory, so verify FAILS until the agent exports BOTH with a single wildcard. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_partial_export.cpex_wca")->set("marker", "wca-marker")->save();
  \Drupal::configFactory()->getEditable("config_partial_export.cpex_wcb")->set("marker", "wcb-marker")->save();
' >/dev/null 2>&1
SYNC=$(drush ev 'print \Drupal::service("file_system")->realpath(\Drupal\Core\Site\Settings::get("config_sync_directory"));' 2>/dev/null)
if [ -n "$SYNC" ]; then
  rm -f "$SYNC/config_partial_export.cpex_wca.yml" "$SYNC/config_partial_export.cpex_wcb.yml"
fi
echo "reset: active config_partial_export.cpex_wca + cpex_wcb present; sync files removed from $SYNC"
