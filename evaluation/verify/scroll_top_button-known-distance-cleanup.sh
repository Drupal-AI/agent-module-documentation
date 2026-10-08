#!/usr/bin/env bash
# Introspection CLEANUP: restore scroll_top_button.settings shipped defaults. Idempotent. Exit 0.
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
echo "cleanup: scroll_top_button.settings restored to shipped defaults"
