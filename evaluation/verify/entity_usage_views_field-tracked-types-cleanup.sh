#!/usr/bin/env bash
# Introspection CLEANUP: restore Entity Usage to tracking all target types (empty list = the
# shipped "track everything" behavior). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_usage.settings")
    ->set("track_enabled_target_entity_types", [])->save();
' >/dev/null 2>&1
echo "cleanup: entity_usage.settings track_enabled_target_entity_types reset to [] (track all)"
