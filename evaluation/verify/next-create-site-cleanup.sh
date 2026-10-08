#!/usr/bin/env bash
# next execution CLEANUP: delete next_site nextzz_task.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\next\Entity\NextSite; if ($s = NextSite::load("nextzz_task")) { $s->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: next_site nextzz_task removed"
