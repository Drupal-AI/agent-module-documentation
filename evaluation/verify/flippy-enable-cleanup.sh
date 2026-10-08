#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("flippy.settings")->clear("flippy_article")->save();' >/dev/null 2>&1
echo "cleanup: flippy_article cleared"
