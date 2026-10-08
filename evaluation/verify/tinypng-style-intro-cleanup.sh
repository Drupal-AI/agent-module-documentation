#!/usr/bin/env bash
# Introspection CLEANUP: delete the tinypng_intro image style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("tinypng_intro")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tinypng_intro removed"
