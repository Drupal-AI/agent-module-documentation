#!/usr/bin/env bash
# Execution RESET: restore the shipped Image extension list so verify FAILS until the agent
# adds the new formats. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "image", "field_media_image");
  $s = $f->getSettings();
  $s["file_extensions"] = "png gif jpg jpeg webp";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "reset: media image file_extensions='png gif jpg jpeg webp'"
