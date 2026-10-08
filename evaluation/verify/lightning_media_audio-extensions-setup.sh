#!/usr/bin/env bash
# Introspection SETUP: put a known, non-default allowed-extension list on the Audio media
# type's source field (field_media_audio_file) so the agent must read the live field config.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "audio", "field_media_audio_file");
  $s = $f->getSettings();
  $s["file_extensions"] = "mp3 wav aac flac opus";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "setup: media audio field_media_audio_file file_extensions='mp3 wav aac flac opus'"
