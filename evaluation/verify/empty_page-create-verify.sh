#!/usr/bin/env bash
# Execution VERIFY: PASS when empty_page.settings contains a callback whose path is 'ep-hard'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $data = \Drupal::config("empty_page.settings")->getRawData();
  $found = FALSE;
  foreach ($data as $k=>$v){ if (strpos($k,"callback_")===0 && is_array($v) && ($v["path"]??"")==="ep-hard"){ $found=TRUE; } }
  print ($found ? "PASS" : "FAIL")." found_ep-hard=".var_export($found,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
