#!/usr/bin/env bash
# Introspection SETUP: set color_select to 'black' (default is 'default'). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_extras.settings.apple")->set("color_select","black")->save();' >/dev/null 2>&1
echo "setup: pwa_extras.settings.apple color_select=black"
