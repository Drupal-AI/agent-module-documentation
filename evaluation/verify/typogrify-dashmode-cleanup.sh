#!/usr/bin/env bash
# Introspection CLEANUP: delete the typogrify_eval2 text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("typogrify_eval2")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text format typogrify_eval2 removed"
