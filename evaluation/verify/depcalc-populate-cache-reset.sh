#!/usr/bin/env bash
# Execution RESET: clear the depcalc cache (empty). Verify (cache non-empty) FAILS on this
# empty state until the agent calculates & caches a dependency. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("cache.depcalc")->deleteAllPermanent();' >/dev/null 2>&1
echo "reset: depcalc cache cleared (empty)"
