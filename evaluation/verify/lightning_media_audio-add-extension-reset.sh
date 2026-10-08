#!/usr/bin/env bash
# Execution RESET: restore the shipped Audio extension list so verify FAILS until the agent
# adds the new formats. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "audio", "field_media_audio_file");
  $s = $f->getSettings();
  $s["file_extensions"] = "mp3 wav aac";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "reset: media audio file_extensions='mp3 wav aac'"
