#!/usr/bin/env bash
# Introspection CLEANUP: restore media_thumbnails_video.settings shipped defaults
# (ffmpeg null, ffprobe null, timeout "3600", threads "12"). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_thumbnails_video.settings")
    ->set("ffmpeg", NULL)
    ->set("ffprobe", NULL)
    ->set("timeout", "3600")
    ->set("threads", "12")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media_thumbnails_video.settings restored to defaults"
