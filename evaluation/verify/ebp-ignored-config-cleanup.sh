#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (empty ignored list). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_bundle_permissions.settings")
    ->set("ignored_entity_types", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ignored_entity_types restored to empty"
