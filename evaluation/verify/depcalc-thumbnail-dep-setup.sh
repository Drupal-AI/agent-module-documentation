#!/usr/bin/env bash
# Introspection SETUP: clear the depcalc cache so calculation is fresh. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.depcalc")->deleteAllPermanent();' >/dev/null 2>&1
echo "setup: depcalc cache cleared"
