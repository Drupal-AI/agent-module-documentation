#!/usr/bin/env bash
# Introspection SETUP: set a known maximum image resolution on the Image media type's source
# field so the agent must read the live field config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "image", "field_media_image");
  $s = $f->getSettings();
  $s["max_resolution"] = "1600x1200";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "setup: media image field_media_image max_resolution='1600x1200'"
