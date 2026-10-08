#!/usr/bin/env bash
# Execution VERIFY: PASS when position == bottom_left. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p=\Drupal::config("all_in_one_accessibility.userid.settings")->get("position");
  $ok = ($p === "bottom_left");
  print ($ok?"PASS":"FAIL")." position=".var_export($p,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
