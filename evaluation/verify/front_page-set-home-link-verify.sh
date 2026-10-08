#!/usr/bin/env bash
# Execution VERIFY: PASS when front_page.settings.home_link_path === 'welcome'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("front_page.settings")->get("home_link_path");
  $ok = ($v === "welcome");
  print ($ok ? "PASS" : "FAIL") . " home_link_path=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
