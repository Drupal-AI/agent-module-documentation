#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("media");
  foreach ($st->loadByProperties(["name" => "mdl_dl"]) as $m) {
    if ($m->hasField("field_media_document")) { foreach ($m->field_media_document as $it) { if ($it->entity) { $it->entity->delete(); } } }
    $m->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media 'mdl_dl' removed"
