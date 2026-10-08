#!/usr/bin/env bash
# Introspection SETUP: put a known, distinctive allowed-extension list on the Image media
# type's source field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "image", "field_media_image");
  $s = $f->getSettings();
  $s["file_extensions"] = "png svg";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "setup: media image field_media_image file_extensions='png svg'"
