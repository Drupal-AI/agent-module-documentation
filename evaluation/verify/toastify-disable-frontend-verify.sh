#!/usr/bin/env bash
# Execution VERIFY: PASS when enable_for.frontend_theme is FALSE and enable_for.admin_theme
# is still TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::config("toastify.settings")->get("enable_for.frontend_theme");
  $a = \Drupal::config("toastify.settings")->get("enable_for.admin_theme");
  $ok = (($f === FALSE || $f === 0 || $f === "0") && ($a === TRUE || $a === 1 || $a === "1"));
  print ($ok ? "PASS" : "FAIL") . " frontend=" . var_export($f, TRUE) . " admin=" . var_export($a, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
