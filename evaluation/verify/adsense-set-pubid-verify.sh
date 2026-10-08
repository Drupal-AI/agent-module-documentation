#!/usr/bin/env bash
# Execution VERIFY: PASS when adsense.settings:adsense_basic_id === 'ca-pub-0000000000000000'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("adsense.settings")->get("adsense_basic_id");
  print (($v === "ca-pub-0000000000000000") ? "PASS" : "FAIL") . " adsense_basic_id=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
