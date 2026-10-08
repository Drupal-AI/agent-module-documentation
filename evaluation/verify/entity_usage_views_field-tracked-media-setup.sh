#!/usr/bin/env bash
# Introspection SETUP: restrict Entity Usage tracking to 'media' only. That config
# (entity_usage.settings:track_enabled_target_entity_types) is what decides which entity types
# expose entity_usage_views_field's "Entity usage count" field. Agent reads it live. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_usage.settings")
    ->set("track_enabled_target_entity_types", ["media"])->save();
' >/dev/null 2>&1
echo "setup: track_enabled_target_entity_types = [media]"
