#!/usr/bin/env bash
# Execution VERIFY: PASS when a callback exists with path 'ep-hard2' AND title 'Hard Two'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $data = \Drupal::config("empty_page.settings")->getRawData();
  $ok = FALSE;
  foreach ($data as $k=>$v){ if (strpos($k,"callback_")===0 && is_array($v) && ($v["path"]??"")==="ep-hard2" && ($v["page_title"]??"")==="Hard Two"){ $ok=TRUE; } }
  print ($ok ? "PASS" : "FAIL")." ok=".var_export($ok,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
