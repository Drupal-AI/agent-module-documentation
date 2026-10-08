#!/usr/bin/env bash
# Execution VERIFY: PASS when adsense_oldcode.settings:adsense_group_title_1 === 'Sidebar Skyscraper'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("adsense_oldcode.settings")->get("adsense_group_title_1");
  print (($v === "Sidebar Skyscraper") ? "PASS" : "FAIL") . " adsense_group_title_1=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
