#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default config (only lazy_loading_threshold=1250). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("easy_responsive_images.settings")
    ->set("minimum_width", NULL)
    ->set("maximum_width", NULL)
    ->set("threshold_width", NULL)
    ->set("aspect_ratios", NULL)
    ->set("minimum_height", NULL)
    ->set("maximum_height", NULL)
    ->set("threshold_height", NULL)
    ->set("lazy_loading_threshold", 1250)
    ->save();
' >/dev/null 2>&1
echo "cleanup: easy_responsive_images.settings restored to default (lazy_loading_threshold=1250)"
