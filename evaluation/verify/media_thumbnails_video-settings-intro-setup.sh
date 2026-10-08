#!/usr/bin/env bash
# Introspection SETUP: set media_thumbnails_video.settings to a known configuration (custom
# ffmpeg path + thread count) so an agent can read the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_thumbnails_video.settings")
    ->set("ffmpeg", "/opt/introspect/bin/ffmpeg")
    ->set("ffprobe", "/opt/introspect/bin/ffprobe")
    ->set("threads", "4")
    ->set("timeout", "3600")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media_thumbnails_video.settings ffmpeg=/opt/introspect/bin/ffmpeg threads=4"
