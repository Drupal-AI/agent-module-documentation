#!/usr/bin/env bash
# Execution CLEANUP: delete the shortcode_task text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("shortcode_task")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: shortcode_task removed"
