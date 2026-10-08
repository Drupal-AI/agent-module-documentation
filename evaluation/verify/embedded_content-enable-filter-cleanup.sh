#!/usr/bin/env bash
# Execution CLEANUP: delete the text format 'ec_task_format'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("ec_task_format")) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed text format ec_task_format"
