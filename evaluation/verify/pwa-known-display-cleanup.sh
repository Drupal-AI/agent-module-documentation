#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pwa.config")->set("display","standalone")->save();' >/dev/null 2>&1
echo "cleanup: pwa.config display=standalone (default)"
