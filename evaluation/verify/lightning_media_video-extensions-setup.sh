#!/usr/bin/env bash
# Introspection SETUP: put a known, non-default allowed-extension list on the local Video
# media type's source field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "video", "field_media_video_file");
  $s = $f->getSettings();
  $s["file_extensions"] = "mp4 webm ogv";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "setup: media video field_media_video_file file_extensions='mp4 webm ogv'"
