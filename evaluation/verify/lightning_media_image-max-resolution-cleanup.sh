#!/usr/bin/env bash
# Introspection CLEANUP: clear the maximum resolution again (shipped value is empty).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "image", "field_media_image");
  $s = $f->getSettings();
  $s["max_resolution"] = "";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "cleanup: media image max_resolution cleared"
