#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped skin default (empty string). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("slick.optionset.slick_lightbox")->set("skin", "")->save();' >/dev/null 2>&1
echo "cleanup: slick.optionset.slick_lightbox skin=''"
