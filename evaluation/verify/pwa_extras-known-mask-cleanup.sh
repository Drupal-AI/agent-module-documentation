#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa_extras.settings.apple")->set("mask_color","#0678be")->save();' >/dev/null 2>&1
echo "cleanup: pwa_extras.settings.apple mask_color=#0678be (default)"
