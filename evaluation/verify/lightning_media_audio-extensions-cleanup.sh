#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped Audio extension list (mp3 wav aac).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "audio", "field_media_audio_file");
  $s = $f->getSettings();
  $s["file_extensions"] = "mp3 wav aac";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "cleanup: media audio field_media_audio_file file_extensions restored to 'mp3 wav aac'"
