#!/usr/bin/env bash
# Execution VERIFY: PASS when gin_moderation_sidebar.settings tab_style === 'contrast'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("gin_moderation_sidebar.settings")->get("tab_style");
  print (($v === "contrast") ? "PASS" : "FAIL") . " tab_style=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
