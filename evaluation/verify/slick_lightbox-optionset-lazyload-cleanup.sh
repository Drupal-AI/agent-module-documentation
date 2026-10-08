#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped lazyLoad default ('ondemand'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("slick.optionset.slick_lightbox")->set("options.settings.lazyLoad", "ondemand")->save();' >/dev/null 2>&1
echo "cleanup: slick.optionset.slick_lightbox options.settings.lazyLoad=ondemand"
