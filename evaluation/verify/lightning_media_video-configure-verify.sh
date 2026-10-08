#!/usr/bin/env bash
# Execution VERIFY: PASS when the local Video source field accepts at least mp4, webm and mov
# AND the Remote video media type stores its oEmbed thumbnails in public://lm_remote_thumbs.
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "video", "field_media_video_file");
  $ext = $f ? preg_split("/[,\s]+/", trim((string) $f->getSetting("file_extensions"))) : [];
  $ext = array_map("strtolower", array_filter($ext));
  $missing = array_values(array_diff(["mp4", "webm", "mov"], $ext));
  $t = \Drupal\media\Entity\MediaType::load("remote_video");
  $dir = $t ? ($t->getSource()->getConfiguration()["thumbnails_directory"] ?? NULL) : NULL;
  $checks = ["extensions" => empty($missing), "thumbnails_directory" => ($dir === "public://lm_remote_thumbs")];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " extensions=" . implode(",", $ext) . " thumbnails_directory=" . var_export($dir, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
