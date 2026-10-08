#!/usr/bin/env bash
# next execution RESET: ensure next_site nextzz_task is ABSENT so verify fails on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\next\Entity\NextSite; if ($s = NextSite::load("nextzz_task")) { $s->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: next_site nextzz_task absent"
