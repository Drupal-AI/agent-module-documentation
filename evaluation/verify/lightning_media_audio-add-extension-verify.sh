#!/usr/bin/env bash
# Execution VERIFY: PASS when the Audio media type's source field accepts at least
# mp3, wav, aac, m4a and ogg. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "audio", "field_media_audio_file");
  $ext = $f ? preg_split("/[,\s]+/", trim((string) $f->getSetting("file_extensions"))) : [];
  $ext = array_map("strtolower", array_filter($ext));
  $want = ["mp3", "wav", "aac", "m4a", "ogg"];
  $missing = array_values(array_diff($want, $ext));
  print ($missing ? "FAIL missing=" . implode(",", $missing) : "PASS") . " actual=" . implode(",", $ext) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
