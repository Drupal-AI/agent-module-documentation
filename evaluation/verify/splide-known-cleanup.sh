#!/usr/bin/env bash
# Introspection CLEANUP: delete optionset spl_known.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\splide\Entity\Splide; if ($e = Splide::load("spl_known")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: spl_known removed"
