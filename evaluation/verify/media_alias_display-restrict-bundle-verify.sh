#!/usr/bin/env bash
# Execution VERIFY: PASS when media_alias_display.settings media_bundles restricts to the
# 'document' bundle (the 'document' key is present in the allow-list). exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal::config("media_alias_display.settings")->get("media_bundles");
  $b = is_array($b) ? $b : [];
  $ok = array_key_exists("document", $b) && !empty($b["document"]);
  print ($ok ? "PASS" : "FAIL") . " media_bundles=" . json_encode($b) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
