#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped Image extension list.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "image", "field_media_image");
  $s = $f->getSettings();
  $s["file_extensions"] = "png gif jpg jpeg webp";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "cleanup: media image file_extensions restored to 'png gif jpg jpeg webp'"
