#!/usr/bin/env bash
# Execution VERIFY: PASS when Matomo consent requires "analytics" and no longer the stale
# "legacy_cat".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $raw = \Drupal::config("eu_cookie_compliance_matomo.settings")->get("categories") ?: [];
  $cats = array_values(array_filter($raw));
  $ok = in_array("analytics", $cats, TRUE) && !in_array("legacy_cat", $cats, TRUE);
  print ($ok ? "PASS" : "FAIL") . " categories=" . json_encode($cats) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
