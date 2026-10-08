#!/usr/bin/env bash
# Introspection SETUP: set pwa_extras.settings.apple mask_color to a known value '#abcdef'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_extras.settings.apple")->set("mask_color","#abcdef")->save();' >/dev/null 2>&1
echo "setup: pwa_extras.settings.apple mask_color=#abcdef"
