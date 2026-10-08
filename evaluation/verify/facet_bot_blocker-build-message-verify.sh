#!/usr/bin/env bash
# Execution VERIFY: PASS when facet_bot_blocker_html contains 'FBB blocked you'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $html = (string) \Drupal::config("facet_bot_blocker.settings")->get("facet_bot_blocker_html");
  $ok = (strpos($html, "FBB blocked you") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " html=" . var_export($html, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
