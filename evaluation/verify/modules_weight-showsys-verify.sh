#!/usr/bin/env bash
# Execution VERIFY (modules_weight): PASS when show_system_modules is enabled (TRUE) in
# modules_weight.settings. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("modules_weight.settings")->get("show_system_modules");
  $ok = ((bool) $v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " show_system_modules=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
