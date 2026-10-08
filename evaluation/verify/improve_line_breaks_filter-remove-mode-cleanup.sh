#!/usr/bin/env bash
# Execution CLEANUP: delete the ilbf_remove text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("ilbf_remove")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: filter.format.ilbf_remove removed"
