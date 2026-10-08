#!/usr/bin/env bash
# Introspection CLEANUP: delete the two seeded image styles. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  foreach (["responsive_320w", "responsive_640w"] as $n) { if ($s = ImageStyle::load($n)) { $s->delete(); } }
' >/dev/null 2>&1
echo "cleanup: responsive_320w, responsive_640w deleted"
