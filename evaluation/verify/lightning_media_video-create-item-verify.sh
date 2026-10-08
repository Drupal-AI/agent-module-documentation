#!/usr/bin/env bash
# Execution VERIFY: PASS when a media item named 'LM Video Task' exists in the local video
# bundle (not remote_video) with field_media_video_file referencing a file and
# field_media_in_library TRUE. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "LM Video Task"]);
  $m = $found ? reset($found) : NULL;
  $checks = [
    "exists" => (bool) $m,
    "bundle_is_video" => $m && $m->bundle() === "video",
    "source_field" => $m && $m->hasField("field_media_video_file") && !$m->get("field_media_video_file")->isEmpty(),
    "in_library" => $m && $m->hasField("field_media_in_library") && (bool) $m->get("field_media_in_library")->value,
  ];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS") . " bundle=" . ($m ? $m->bundle() : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
