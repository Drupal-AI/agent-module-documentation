#!/usr/bin/env bash
# Execution CLEANUP: remove the eep_news text format created during the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("eep_news")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: filter_format eep_news removed"
