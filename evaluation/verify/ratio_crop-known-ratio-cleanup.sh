#!/usr/bin/env bash
# Introspection CLEANUP: delete the ratiocrop_known image style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("ratiocrop_known")) { $s->delete(); }
' >/dev/null 2>&1
echo "cleanup: image.style.ratiocrop_known removed"
