#!/usr/bin/env bash
# Execution RESET: force media_thumbnails_video.settings back to shipped defaults (no ffmpeg/
# ffprobe path, threads 12) so verify FAILS until the agent sets the requested paths/threads.
# Idempotent. Exit 0.
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
echo "reset: media_thumbnails_video.settings at defaults (ffmpeg/ffprobe null, threads 12)"
