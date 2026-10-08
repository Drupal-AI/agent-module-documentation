#!/usr/bin/env bash
# Cleanup: delete the htmlawed_med1 text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("htmlawed_med1")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: htmlawed_med1 removed"
