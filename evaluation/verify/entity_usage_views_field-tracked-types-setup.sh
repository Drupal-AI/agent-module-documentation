#!/usr/bin/env bash
# Introspection SETUP: restrict Entity Usage tracking to the 'node' target type only, which is
# what controls the entity types on which entity_usage_views_field exposes its "Entity usage
# count" field. Agent inspects entity_usage.settings live. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_usage.settings")
    ->set("track_enabled_target_entity_types", ["node"])->save();
' >/dev/null 2>&1
echo "setup: entity_usage.settings track_enabled_target_entity_types = [node]"
