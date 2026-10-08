#!/usr/bin/env bash
# Execution VERIFY: PASS when the configured Matomo consent categories include BOTH "analytics" and
# "marketing" (matching how the module itself reads them: truthy values only).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $raw = \Drupal::config("eu_cookie_compliance_matomo.settings")->get("categories") ?: [];
  $cats = array_values(array_filter($raw));   // module filters truthy, works for indexed or checkbox arrays
  $ok = in_array("analytics", $cats, TRUE) && in_array("marketing", $cats, TRUE);
  print ($ok ? "PASS" : "FAIL") . " categories=" . json_encode($cats) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
