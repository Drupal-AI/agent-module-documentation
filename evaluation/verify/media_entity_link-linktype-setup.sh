#!/usr/bin/env bash
# Introspection SETUP: set the Link media type's link field to EXTERNAL-only (link_type=16), so
# an agent can read back which link kinds are allowed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("field.field.media.link.field_media_entity_link");
  $c->set("settings.link_type", 16)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_media_entity_link link_type=16 (external only)"
