#!/usr/bin/env bash
# Execution CLEANUP: delete the pee_exec text format. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("pee_exec")) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: text format pee_exec removed"
