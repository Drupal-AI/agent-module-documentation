#!/usr/bin/env bash
# RESET/CLEANUP: restore scroll_top_button.settings to shipped config/install defaults so a hard
# verify FAILS on this baseline and the site is left clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("scroll_top_button.settings")
    ->set("enabled", "off")
    ->set("show_on_admin", FALSE)
    ->set("button_text", "Scroll to top")
    ->set("button_style", "image")
    ->set("button_animation", "fade")
    ->set("button_animation_speed", 200)
    ->set("scroll_distance", 100)
    ->set("scroll_speed", 300)
    ->save();
' >/dev/null 2>&1
echo "reset: scroll_top_button.settings restored to shipped defaults"
