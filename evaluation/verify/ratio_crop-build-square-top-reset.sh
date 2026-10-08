#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure image style ratiocrop_square does NOT exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("ratiocrop_square")) { $s->delete(); }
' >/dev/null 2>&1
echo "reset: image.style.ratiocrop_square removed"
