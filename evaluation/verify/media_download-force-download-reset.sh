#!/usr/bin/env bash
# Execution RESET: remove any media named 'mdl_dl' so verify FAILS until the agent creates a
# downloadable document media whose /media/{id}?dl=1 forces an attachment download. Exit 0.
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
echo "reset: media 'mdl_dl' absent"
