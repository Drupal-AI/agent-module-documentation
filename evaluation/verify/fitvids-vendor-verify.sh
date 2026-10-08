#!/usr/bin/env bash
# Execution VERIFY: PASS when fitvids.settings custom_vendors contains 'https://videopress.com'
# AND ignore_selectors contains '.slick-slider'. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("fitvids.settings");
  $cv = (string) ($cfg->get("custom_vendors") ?? "");
  $ig = (string) ($cfg->get("ignore_selectors") ?? "");
  $ok = (strpos($cv, "https://videopress.com") !== FALSE) && (strpos($ig, ".slick-slider") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " vendor=" . (strpos($cv, "videopress") !== FALSE ? "yes" : "no") . " ignore=" . (strpos($ig, "slick-slider") !== FALSE ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
