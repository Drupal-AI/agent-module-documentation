#!/usr/bin/env bash
# Execution CLEANUP: restore link_type=17 (shipped default). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("field.field.media.link.field_media_entity_link");
  $c->set("settings.link_type", 17)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_media_entity_link link_type restored to 17"
