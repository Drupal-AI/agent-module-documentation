#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped slidesToShow default (1). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("slick.optionset.slick_lightbox")->set("options.settings.slidesToShow", 1)->save();' >/dev/null 2>&1
echo "cleanup: slick.optionset.slick_lightbox options.settings.slidesToShow=1"
