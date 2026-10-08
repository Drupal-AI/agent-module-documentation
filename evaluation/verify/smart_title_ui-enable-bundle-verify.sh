#!/usr/bin/env bash
# Execution VERIFY: PASS when node:article is in the Smart Title eligible bundle list. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("smart_title.settings")->get("smart_title") ?: [];
  $ok = in_array("node:article", $v, TRUE);
  print ($ok ? "PASS" : "FAIL") . " list=" . implode(",", $v) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
