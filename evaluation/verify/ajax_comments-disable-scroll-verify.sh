#!/usr/bin/env bash
# Execution VERIFY: PASS when enable_scroll===false. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("ajax_comments.settings")->get("enable_scroll");
  $ok = ($s === FALSE);
  print ($ok ? "PASS" : "FAIL") . " enable_scroll=" . var_export($s, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
