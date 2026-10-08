#!/usr/bin/env bash
# Execution CLEANUP: delete the md_task text format. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("md_task")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format md_task removed"
