#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.depcalc")->deleteAllPermanent();' >/dev/null 2>&1
echo "cleanup: depcalc cache cleared"
