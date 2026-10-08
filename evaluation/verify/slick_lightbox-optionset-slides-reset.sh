#!/usr/bin/env bash
# Execution RESET: force the slick_lightbox optionset slidesToShow back to the shipped default
# (1) so verify (which expects 2) FAILS until the agent changes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("slick.optionset.slick_lightbox")->set("options.settings.slidesToShow", 1)->save();' >/dev/null 2>&1
echo "reset: slick.optionset.slick_lightbox options.settings.slidesToShow=1"
