#!/usr/bin/env bash
# CLEANUP: remove only salg_-prefixed geocoder providers (leaves any others untouched).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("geocoder_provider");
  foreach ($s->loadMultiple() as $id => $p) { if (strpos($id, "salg_") === 0) { $p->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: salg_* geocoder providers removed"
