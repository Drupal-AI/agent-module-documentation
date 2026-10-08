#!/usr/bin/env bash
# Introspection CLEANUP: delete the ilbf_replace text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("ilbf_replace")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: filter.format.ilbf_replace removed"
