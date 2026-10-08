#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped link_type=17 (both internal + external). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("field.field.media.link.field_media_entity_link");
  $c->set("settings.link_type", 17)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_media_entity_link link_type restored to 17"
