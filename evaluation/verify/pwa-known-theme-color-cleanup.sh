#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa.config")->set("theme_color","#ffffff")->save();' >/dev/null 2>&1
echo "cleanup: pwa.config theme_color=#ffffff (default)"
