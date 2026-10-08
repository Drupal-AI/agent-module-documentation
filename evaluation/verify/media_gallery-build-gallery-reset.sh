#!/usr/bin/env bash
# Execution RESET: force baseline so verify FAILS until the agent builds the gallery. Deletes
# any media_gallery entity titled "MG Task Gallery". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("media_gallery");
  foreach ($s->loadByProperties(["title" => "MG Task Gallery"]) as $g) { $g->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no media_gallery titled 'MG Task Gallery' exists"
