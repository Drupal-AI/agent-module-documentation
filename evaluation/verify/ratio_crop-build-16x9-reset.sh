#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure image style ratiocrop_task does NOT exist, so verify FAILS
# on empty state and the site is left clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("ratiocrop_task")) { $s->delete(); }
' >/dev/null 2>&1
echo "reset: image.style.ratiocrop_task removed"
