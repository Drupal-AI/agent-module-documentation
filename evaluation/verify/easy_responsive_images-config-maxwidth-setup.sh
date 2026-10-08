#!/usr/bin/env bash
# Introspection SETUP: write a known Easy Responsive Images generation config (max width 1600). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("easy_responsive_images.settings")
    ->set("minimum_width", "400")
    ->set("maximum_width", "1600")
    ->set("threshold_width", "400")
    ->set("aspect_ratios", "16:9")
    ->set("lazy_loading_threshold", 1250)
    ->save();
' >/dev/null 2>&1
echo "setup: easy_responsive_images.settings maximum_width=1600 (min=400 step=400 ratios=16:9)"
