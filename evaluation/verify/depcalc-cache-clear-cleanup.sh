#!/usr/bin/env bash
# CLEANUP/RESET: clear the depcalc cache bin (leaves it empty/clean). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.depcalc")->deleteAllPermanent();' >/dev/null 2>&1
echo "cleanup: depcalc cache cleared"
