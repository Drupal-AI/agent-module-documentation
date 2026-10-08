#!/usr/bin/env bash
# Execution RESET: remove any media named 'mdl_task' (and its file) so verify FAILS until the
# agent creates a downloadable document media. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("media");
  foreach ($st->loadByProperties(["name" => "mdl_task"]) as $m) {
    foreach ($m as $field) {}
    if ($m->hasField("field_media_document")) { foreach ($m->field_media_document as $it) { if ($it->entity) { $it->entity->delete(); } } }
    $m->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media 'mdl_task' absent"
