#!/usr/bin/env bash
# Execution CLEANUP: remove the eep_fmt text format created during the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("eep_fmt")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: filter_format eep_fmt removed"
