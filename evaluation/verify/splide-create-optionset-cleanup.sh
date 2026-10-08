#!/usr/bin/env bash
# Execution CLEANUP: delete optionset spl_task.
# creates it as an infinite loop showing 3 per page. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\splide\Entity\Splide; if ($e = Splide::load("spl_task")) { $e->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: spl_task removed"
