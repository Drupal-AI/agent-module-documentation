#!/usr/bin/env bash
# Introspection CLEANUP: delete image style ac_known. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\image\Entity\ImageStyle; if ($s = ImageStyle::load("ac_known")) { $s->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: image style ac_known removed"
