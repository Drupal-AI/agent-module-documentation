#!/usr/bin/env bash
# Introspection CLEANUP: remove image style cis_seed_b. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if ($s = ImageStyle::load("cis_seed_b")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: image.style.cis_seed_b removed"
