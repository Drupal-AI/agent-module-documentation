#!/usr/bin/env bash
# Execution VERIFY: PASS when puphpeteer.settings executable_path === '/usr/bin/node'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("puphpeteer.settings")->get("executable_path");
  $ok = ($v === "/usr/bin/node");
  print ($ok ? "PASS" : "FAIL") . " executable_path=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
