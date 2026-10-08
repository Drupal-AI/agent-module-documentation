#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("htmlawed_schemes")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: htmlawed_schemes removed"
