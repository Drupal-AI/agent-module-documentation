#!/usr/bin/env bash
# Execution VERIFY: PASS when a media item named 'LM Audio Task' exists in the audio bundle,
# its source field field_media_audio_file references a file, and Lightning Media's
# field_media_in_library is FALSE (hidden from the media library). exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "LM Audio Task"]);
  $checks = [];
  $checks["exists"] = (bool) $found;
  $m = $found ? reset($found) : NULL;
  $checks["bundle"] = $m && $m->bundle() === "audio";
  $checks["source_field"] = $m && $m->hasField("field_media_audio_file") && !$m->get("field_media_audio_file")->isEmpty();
  $checks["hidden_from_library"] = $m && $m->hasField("field_media_in_library") && !$m->get("field_media_in_library")->value;
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " bundle=" . ($m ? $m->bundle() : "none") . " in_library=" . ($m && $m->hasField("field_media_in_library") ? var_export((bool) $m->get("field_media_in_library")->value, TRUE) : "n/a") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
