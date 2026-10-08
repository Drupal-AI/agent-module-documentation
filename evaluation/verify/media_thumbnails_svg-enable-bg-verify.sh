#!/usr/bin/env bash
# Execution VERIFY: PASS when a custom background color is enabled with value #ffffff.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("media_thumbnails.settings");
  $active = $cfg->get("bgcolor_active"); $val = strtolower((string)$cfg->get("bgcolor_value"));
  print ((!empty($active) && $val === "#ffffff") ? "PASS" : "FAIL")." active=".var_export($active,TRUE)." value=".$val."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
