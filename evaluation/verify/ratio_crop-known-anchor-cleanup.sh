#!/usr/bin/env bash
# Introspection CLEANUP: delete the ratiocrop_anchor image style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("ratiocrop_anchor")) { $s->delete(); }
' >/dev/null 2>&1
echo "cleanup: image.style.ratiocrop_anchor removed"
