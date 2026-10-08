#!/usr/bin/env bash
# Introspection CLEANUP (medium): clear the default image UUID set on the media image field,
# restoring baseline. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("field.field.media.image.field_media_image");
  $s = $c->get("settings");
  $s["default_image"]["uuid"] = NULL;
  $c->set("settings", $s)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: default image UUID cleared on media.image.field_media_image"
