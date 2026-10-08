#!/usr/bin/env bash
# Execution CLEANUP: restore media_thumbnails_video.settings shipped defaults. Idempotent.
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
