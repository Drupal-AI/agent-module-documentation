#!/usr/bin/env bash
# Introspection CLEANUP: delete the mdc_eval_format text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("mdc_eval_format")) { $f->delete(); }
' >/dev/null 2>&1

echo "cleanup: mdc_eval_format removed"
