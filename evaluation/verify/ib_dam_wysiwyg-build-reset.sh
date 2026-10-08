#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete ibw_build_fmt so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("ibw_build_fmt")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ibw_build_fmt removed"
