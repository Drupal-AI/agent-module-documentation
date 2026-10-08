#!/usr/bin/env bash
# Execution VERIFY: PASS when the EPT desktop breakpoint is 1440. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal::config("ept_core.settings")->get("ept_core_desktop_breakpoint");
  print (((string) $b === "1440") ? "PASS" : "FAIL") . " desktop_breakpoint=" . var_export($b, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
