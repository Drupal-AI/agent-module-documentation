#!/usr/bin/env bash
# Introspection SETUP: create a published media_gallery entity with a known title so an
# inspecting agent can read it back off the live site. Idempotent (removes any prior copy
# first). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("media_gallery");
  foreach ($s->loadByProperties(["title" => "MG Known Gallery"]) as $g) { $g->delete(); }
  $g = $s->create(["title" => "MG Known Gallery", "status" => 1]);
  $g->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media_gallery entity 'MG Known Gallery' created (published)"
