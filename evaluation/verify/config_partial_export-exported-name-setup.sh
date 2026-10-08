#!/usr/bin/env bash
# Introspection SETUP: create a known active config object and use config_partial_export's
# drush command to export it into the config sync directory, so an inspecting agent can find
# which object was exported. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_partial_export.cpex_intro")->set("marker", "cpex-intro-value")->save();' >/dev/null 2>&1
drush cpex config_partial_export.cpex_intro >/dev/null 2>&1
SYNC=$(drush ev 'print \Drupal::service("file_system")->realpath(\Drupal\Core\Site\Settings::get("config_sync_directory"));' 2>/dev/null)
echo "setup: config_partial_export exported config_partial_export.cpex_intro into $SYNC"
