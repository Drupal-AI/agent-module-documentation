#!/usr/bin/env bash
# Execution CLEANUP: delete the typogrify_eval_h text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("typogrify_eval_h")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format typogrify_eval_h removed"
