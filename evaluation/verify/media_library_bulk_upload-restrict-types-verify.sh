#!/usr/bin/env bash
# Live-state verification for the "restrict bulk upload to Image + Document only" task.
# Reads config media_library_bulk_upload.settings:media_types and checks that Image and
# Document are enabled while Audio/Video/Remote video are NOT (a media type counts as
# enabled only when its stored value is truthy/equal to its id — the settings-form
# checkboxes element stores unchecked boxes as 0). Prints PASS/FAIL; exits 0 (pass)/1.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $mt = \Drupal::config("media_library_bulk_upload.settings")->get("media_types") ?: [];
  $on = function ($id) use ($mt) { return isset($mt[$id]) && !empty($mt[$id]) && (string) $mt[$id] === $id; };
  $img = $on("image");
  $doc = $on("document");
  $others_off = !$on("audio") && !$on("video") && !$on("remote_video");
  $pass = $img && $doc && $others_off;
  print ($pass ? "PASS" : "FAIL") . " image=" . ($img?1:0) . " document=" . ($doc?1:0) . " others_off=" . ($others_off?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
