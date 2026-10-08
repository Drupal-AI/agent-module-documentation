#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("media");
  foreach ($st->loadByProperties(["name" => "mdl_known"]) as $m) {
    foreach ($m->field_media_document as $item) { if ($item->entity) { $item->entity->delete(); } }
    $m->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media 'mdl_known' removed"
