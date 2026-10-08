#!/usr/bin/env bash
# Introspection CLEANUP: delete the shortcode_eval2 text format created by the matching setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("shortcode_eval2")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: shortcode_eval2 removed"
