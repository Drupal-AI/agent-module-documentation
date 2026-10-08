#!/usr/bin/env bash
# Execution VERIFY: PASS when media_thumbnails_video.settings has ffmpeg=/usr/bin/ffmpeg,
# ffprobe=/usr/bin/ffprobe and threads=6. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("media_thumbnails_video.settings");
  $ffmpeg = $c->get("ffmpeg");
  $ffprobe = $c->get("ffprobe");
  $threads = (string) $c->get("threads");
  $ok = ($ffmpeg === "/usr/bin/ffmpeg" && $ffprobe === "/usr/bin/ffprobe" && $threads === "6");
  print ($ok ? "PASS" : "FAIL") . " ffmpeg=" . var_export($ffmpeg, TRUE) . " ffprobe=" . var_export($ffprobe, TRUE) . " threads=" . var_export($threads, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
