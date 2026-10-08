#!/usr/bin/env bash
# Introspection SETUP: switch facebook_pixel to "the listed pages only" with two distinctive
# paths, so the agent must read facebook_pixel.settings from the live site to say where the
# pixel fires. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("facebook_pixel.settings")
    ->set("visibility.request_path_mode", "listed_pages")
    ->set("visibility.request_path_pages", "/fbp-eval-landing\n/fbp-eval-landing/*")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: facebook_pixel request_path_mode=listed_pages pages=/fbp-eval-landing(+/*)"
