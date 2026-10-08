#!/usr/bin/env bash
# Introspection SETUP: configure image_style_warmer so the 'large' image style is generated
# via the cron queue worker (queue_image_styles), and 'thumbnail' initially. An inspecting
# agent should read image_style_warmer.settings and report which style is queued. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("image_style_warmer.settings")
    ->set("initial_image_styles", ["thumbnail" => "thumbnail"])
    ->set("queue_image_styles", ["large" => "large"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image_style_warmer.settings initial=[thumbnail] queue=[large]"
