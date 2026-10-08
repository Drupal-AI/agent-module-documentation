#!/usr/bin/env bash
# Execution VERIFY: PASS when Widen asset group UUID ag-uuid-task-888 is mapped to the Video
# media type (acquia_dam_video_asset) in acquiadam_asset_import.settings. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $g = \Drupal::config("acquiadam_asset_import.settings")->get("asset_groups") ?: [];
  $m = $g["ag-uuid-task-888"] ?? [];
  $ok = is_array($m) && in_array("acquia_dam_video_asset", $m, TRUE);
  print ($ok ? "PASS" : "FAIL") . " mapping=" . json_encode($m) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
