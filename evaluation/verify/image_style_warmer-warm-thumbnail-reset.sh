#!/usr/bin/env bash
# Execution RESET: clear image_style_warmer.settings so verify FAILS until the agent enables
# initial warming of the thumbnail style. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("image_style_warmer.settings")
    ->set("initial_image_styles", [])
    ->set("queue_image_styles", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: image_style_warmer.settings cleared"
