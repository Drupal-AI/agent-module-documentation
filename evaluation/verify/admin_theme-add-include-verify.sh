#!/usr/bin/env bash
# Execution VERIFY: PASS when admin_theme.settings paths includes /company-dashboard.
# Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = (string) \Drupal::config("admin_theme.settings")->get("paths");
  $ok = (strpos($p, "/company-dashboard") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " paths=" . str_replace("\n", "|", $p) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
