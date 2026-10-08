#!/usr/bin/env bash
# Introspection SETUP: configure image_style_warmer so the 'medium' image style is generated
# initially (synchronously on upload) via initial_image_styles. An inspecting agent should read
# image_style_warmer.settings and report which style warms on upload. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("image_style_warmer.settings")
    ->set("initial_image_styles", ["medium" => "medium"])
    ->set("queue_image_styles", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image_style_warmer.settings initial=[medium] queue=[]"
