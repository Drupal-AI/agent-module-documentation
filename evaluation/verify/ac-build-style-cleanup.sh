#!/usr/bin/env bash
# Execution CLEANUP: delete image style ac_build. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\image\Entity\ImageStyle; if ($s = ImageStyle::load("ac_build")) { $s->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: image style ac_build removed"
