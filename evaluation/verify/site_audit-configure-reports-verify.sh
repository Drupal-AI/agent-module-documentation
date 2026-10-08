#!/usr/bin/env bash
# Execution VERIFY: PASS when site_audit.settings reports enables exactly the cache and status
# reports (their truthy entries). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::config("site_audit.settings")->get("reports") ?? [];
  $on = array_keys(array_filter($r));
  sort($on);
  $ok = ($on === ["cache", "status"]);
  print ($ok ? "PASS" : "FAIL") . " enabled=[" . implode(",", $on) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
