#!/usr/bin/env bash
# Execution VERIFY: PASS when the DAM Image media type is configured to download+sync assets
# locally (source_configuration.download_assets === TRUE). Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("media_type")->load("acquia_dam_image_asset");
  $v = $t ? ($t->get("source_configuration")["download_assets"] ?? NULL) : NULL;
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " download_assets=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
