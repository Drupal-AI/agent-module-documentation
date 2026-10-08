#!/usr/bin/env bash
# Execution CLEANUP: restore both shipped values.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "video", "field_media_video_file");
  $s = $f->getSettings();
  $s["file_extensions"] = "mp4";
  $f->set("settings", $s)->save();
  $t = \Drupal\media\Entity\MediaType::load("remote_video");
  $c = $t->getSource()->getConfiguration();
  $c["thumbnails_directory"] = "public://oembed_thumbnails/[date:custom:Y-m]";
  $t->set("source_configuration", $c)->save();
' >/dev/null 2>&1
echo "cleanup: video extensions and remote_video thumbnails_directory restored"
