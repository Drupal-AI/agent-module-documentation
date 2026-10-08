#!/usr/bin/env bash
# Execution VERIFY: PASS when media_types maps source_type image -> media_type image.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rows = \Drupal::config("ib_dam_media.settings")->get("media_types") ?: [];
  $ok = FALSE;
  foreach ($rows as $r) {
    if (($r["source_type"] ?? NULL) === "image" && ($r["media_type"] ?? NULL) === "image") { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " media_types=" . json_encode($rows) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
