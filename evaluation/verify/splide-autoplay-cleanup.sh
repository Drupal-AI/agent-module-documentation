#!/usr/bin/env bash
# Execution CLEANUP: delete optionset spl_edit.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\splide\Entity\Splide; if ($e = Splide::load("spl_edit")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: spl_edit removed"
