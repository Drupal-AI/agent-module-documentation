#!/usr/bin/env bash
# Execution RESET: force the Link media type's link field back to link_type=17 (both), so verify
# (wants external-only 16) FAILS until the agent restricts it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("field.field.media.link.field_media_entity_link");
  $c->set("settings.link_type", 17)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_media_entity_link link_type=17"
