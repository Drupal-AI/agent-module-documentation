#!/usr/bin/env bash
# Introspection CLEANUP: delete the media_gallery entity created by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("media_gallery");
  foreach ($s->loadByProperties(["title" => "MG Known Gallery"]) as $g) { $g->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'MG Known Gallery' removed"
