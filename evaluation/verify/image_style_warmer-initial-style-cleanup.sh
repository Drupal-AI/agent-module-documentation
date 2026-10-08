#!/usr/bin/env bash
# Introspection CLEANUP: restore image_style_warmer.settings to shipped defaults (both empty).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("image_style_warmer.settings")
    ->set("initial_image_styles", [])
    ->set("queue_image_styles", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: image_style_warmer.settings reset to empty lists"
