#!/usr/bin/env bash
# Execution RESET: ensure the media type mea_task does NOT exist, so verify FAILS until the
# agent creates a media type using the media_entity_audio 'audio_stream' source. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mea_task.default")) { $vd->delete(); }
  if ($fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("media.mea_task.default")) { $fd->delete(); }
  if ($t = MediaType::load("mea_task")) {
    $sf = $t->get("source_configuration")["source_field"] ?? NULL;
    $t->delete();
    if ($sf && ($fsc = FieldStorageConfig::loadByName("media", $sf))) { $fsc->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media type mea_task absent"
