#!/usr/bin/env bash
# Execution CLEANUP: remove the mee_ready text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("mee_ready")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: filter.format.mee_ready removed"
