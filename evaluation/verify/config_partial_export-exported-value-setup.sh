#!/usr/bin/env bash
# Introspection SETUP: create a known active config object with a distinctive value and export
# it into the config sync directory via config_partial_export, so an agent can read the value
# out of the exported YAML. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_partial_export.cpex_meta")->set("answer", 42)->set("label", "cpex-meta")->save();' >/dev/null 2>&1
drush cpex config_partial_export.cpex_meta >/dev/null 2>&1
SYNC=$(drush ev 'print \Drupal::service("file_system")->realpath(\Drupal\Core\Site\Settings::get("config_sync_directory"));' 2>/dev/null)
echo "setup: config_partial_export exported config_partial_export.cpex_meta (answer: 42) into $SYNC"
