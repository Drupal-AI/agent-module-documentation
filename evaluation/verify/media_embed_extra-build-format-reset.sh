#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete the mee_embed text format so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("mee_embed")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter.format.mee_embed absent"
