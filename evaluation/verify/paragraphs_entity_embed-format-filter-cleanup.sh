#!/usr/bin/env bash
# Introspection CLEANUP: delete the pee_format text format. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("pee_format")) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: text format pee_format removed"
