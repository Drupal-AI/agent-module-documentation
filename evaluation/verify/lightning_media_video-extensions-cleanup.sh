#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped Video extension list (mp4).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "video", "field_media_video_file");
  $s = $f->getSettings();
  $s["file_extensions"] = "mp4";
  $f->set("settings", $s)->save();
' >/dev/null 2>&1
echo "cleanup: media video file_extensions restored to 'mp4'"
