#!/usr/bin/env bash
# Introspection SETUP: set pwa.config display to a known non-default value 'fullscreen'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa.config")->set("display","fullscreen")->save();' >/dev/null 2>&1
echo "setup: pwa.config display=fullscreen"
