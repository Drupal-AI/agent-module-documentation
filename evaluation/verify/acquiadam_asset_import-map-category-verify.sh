#!/usr/bin/env bash
# Execution VERIFY: PASS when Widen category UUID cat-uuid-task-777 is mapped to the Image
# media type (acquia_dam_image_asset) in acquiadam_asset_import.settings. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("acquiadam_asset_import.settings")->get("categories") ?: [];
  $m = $c["cat-uuid-task-777"] ?? [];
  $ok = is_array($m) && in_array("acquia_dam_image_asset", $m, TRUE);
  print ($ok ? "PASS" : "FAIL") . " mapping=" . json_encode($m) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
